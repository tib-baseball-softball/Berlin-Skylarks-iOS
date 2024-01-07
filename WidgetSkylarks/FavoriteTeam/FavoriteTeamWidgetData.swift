//
//  FavoriteTeamWidgetData.swift
//  WidgetSkylarksExtension
//
//  Created by David Battefeld on 04.07.22.
//

import WidgetKit
import SwiftUI
import Intents

struct FavoriteTeamProvider: IntentTimelineProvider {
    
    typealias Entry = FavoriteTeamEntry
    
    var widgetData = FavoriteTeamWidgetData()
    
    //always uses current season
    let season = Calendar(identifier: .gregorian).dateComponents([.year], from: .now).year!
    
    func team(for configuration: FavoriteTeamIntent) async -> BSMTeam {
        var teams = [BSMTeam]()
        var selectedTeam = emptyTeam
        
        do {
            teams = try await loadSkylarksTeams(season: season)
        } catch {
            print("Request failed with error: \(error)")
        }
        for team in teams where team.league_entries[0].league.name == configuration.team?.identifier {
            selectedTeam = team
        }
        
        //failsafe option to make sure there is always a real team selected. Kreisliga is used as the team name for the default value provided above
        if selectedTeam.league_entries[0].league.name == "Kreisliga" {
            if !teams.isEmpty {
                selectedTeam = teams.randomElement()!
            }
        }
        
        return selectedTeam
    }
    
    //TODO: this seems to do absolutely nothing right now. Since the team() func always returns a team even if nothing is set in the intent, the result is actually okay
    func recommendations() async -> [IntentRecommendation<FavoriteTeamIntent>] {
        var teams = [BSMTeam]()
        
        do {
            teams = try await loadSkylarksTeams(season: season)
        } catch {
            print("Request failed with error: \(error)")
        }
        
        return teams.map { team in
            let team = BSMTeam(id: team.id, name: team.name, short_name: team.short_name, league_entries: team.league_entries)
            let intent = FavoriteTeamIntent()
            intent.team = BEATeam(identifier: team.league_entries[0].league.name, display: team.league_entries[0].league.name)
            
            return IntentRecommendation(intent: intent, description: Text(team.league_entries[0].league.name))
        }
    }
    
    func placeholder(in context: Context) -> FavoriteTeamEntry {
        //note sure where this data is displayed
        FavoriteTeamEntry(date: Date(), configuration: FavoriteTeamIntent(), team: widgetPreviewTeam, lastGame: widgetPreviewLastGame, lastGameRoadLogo: TeamImageData.flamingosLogo, lastGameHomeLogo: TeamImageData.skylarksSecondaryLogo, nextGame: widgetPreviewNextGame, nextGameOpponentLogo: TeamImageData.sluggersLogo, skylarksAreRoadTeam: false, Table: widgetData.leagueTable, TableRow: widgetData.tableRow)
    }

    func getSnapshot(for configuration: FavoriteTeamIntent, in context: Context, completion: @escaping (FavoriteTeamEntry) -> ()) {
        //this method provides the data for the preview in the widget gallery
        let entry = FavoriteTeamEntry(date: Date(), configuration: FavoriteTeamIntent(), team: widgetPreviewTeam, lastGame: widgetPreviewLastGame, lastGameRoadLogo: TeamImageData.flamingosLogo, lastGameHomeLogo: TeamImageData.skylarksSecondaryLogo, nextGame: widgetPreviewNextGame, nextGameOpponentLogo: TeamImageData.sluggersLogo, skylarksAreRoadTeam: false, Table: widgetData.leagueTable, TableRow: widgetData.tableRow)
        completion(entry)
    }

    func getTimeline(for configuration: FavoriteTeamIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        Task {
            let selectedTeam = await team(for: configuration)
            
            //MARK: DEBUG
            // first we load the tables to infer the league ID for scores
            
            let leagueGroups = await loadLeagueGroups(season: season)
            
            if let table = await loadTableForTeam(team: selectedTeam, leagueGroups: leagueGroups) {
                widgetData.leagueTable = table
                widgetData.tableRow = determineTableRow(team: selectedTeam, table: widgetData.leagueTable)
            }
            
            
            var gamescores = [GameScore]()
            
            //get correct URL for team
            for leagueGroup in leagueGroups where selectedTeam.league_entries[0].league.name == leagueGroup.name {
                let scoresURL = URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=" + "\(season)" + "&search=skylarks&filters[leagues][]=" + "\(leagueGroup.id)" + "&filters[gamedays][]=any&api_key=" + apiKey)!
                
                //load games
                gamescores = try await fetchBSMData(url: scoresURL, dataType: [GameScore].self)
            }
//            loadBSMData(url: team1.scoresURL, dataType: [GameScore].self) { gamescores in
                
            //create tuple with two GameScores
            let displayGames = processGameDates(gamescores: gamescores)
            
            //initialise variables so they always have a fallback value
            var lastGameRoadLogo = TeamImageData.away_team_logo
            var lastGameHomeLogo = TeamImageData.home_team_logo
            
            var nextGameRoadLogo = TeamImageData.away_team_logo
            var nextGameHomeLogo = TeamImageData.home_team_logo
            
            var nextGameOpponentLogo = TeamImageData.away_team_logo
            
            var skylarksAreRoadTeam = false
            
            //check for last game
            if let lastGame = displayGames.last {
                let logos = TeamImageData.fetchCorrectLogos(gamescore: lastGame)
                lastGameRoadLogo = logos.road
                lastGameHomeLogo = logos.home
            }
            
            //check for next game
            if let nextGame = displayGames.next {
                let logos = TeamImageData.fetchCorrectLogos(gamescore: nextGame)
                nextGameRoadLogo = logos.road
                nextGameHomeLogo = logos.home
                
                if nextGame.away_team_name.contains("Skylarks") && !nextGame.home_team_name.contains("Skylarks") {
                    nextGameOpponentLogo = nextGameHomeLogo
                    skylarksAreRoadTeam = true
                } else if !nextGame.away_team_name.contains("Skylarks") && nextGame.home_team_name.contains("Skylarks") {
                    skylarksAreRoadTeam = false
                    nextGameOpponentLogo = nextGameRoadLogo
                }
            }
            
            var entries: [FavoriteTeamEntry] = []

            //Original: Generate a timeline consisting of 3 entries an hour apart, starting from the current date.
            //changed it to update every 20 minutes (hopefully) and created 5 timeline entries
            let currentDate = Date()
            for hourOffset in 0 ..< 1 {
                let entryDate = Calendar.current.date(byAdding: .minute, value: hourOffset * 20, to: currentDate)!
                let entry = FavoriteTeamEntry(date: entryDate, configuration: configuration, team: selectedTeam, lastGame: displayGames.last, lastGameRoadLogo: lastGameRoadLogo, lastGameHomeLogo: lastGameHomeLogo, nextGame: displayGames.next, nextGameOpponentLogo: nextGameOpponentLogo, skylarksAreRoadTeam: skylarksAreRoadTeam, Table: widgetData.leagueTable, TableRow: widgetData.tableRow)
                entries.append(entry)
            }

            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
    }
}

struct WidgetSkylarksEntryView : View {
    var entry: FavoriteTeamProvider.Entry

    var body: some View {
        FavoriteTeamWidgetView(entry: entry)
    }
}
