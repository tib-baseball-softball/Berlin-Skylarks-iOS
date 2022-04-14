//
//  WidgetSkylarks.swift
//  WidgetSkylarks
//
//  Created by David Battefeld on 21.12.21.
//

import WidgetKit
import SwiftUI
import Intents

struct FavoriteTeamProvider: IntentTimelineProvider {
    
    typealias Entry = FavoriteTeamEntry
    
    var userDashboard = UserDashboard()
    
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
    
    func placeholder(in context: Context) -> FavoriteTeamEntry {
        //note sure where this data is displayed
        FavoriteTeamEntry(date: Date(), configuration: FavoriteTeamIntent(), team: widgetPreviewTeam, lastGame: widgetPreviewLastGame, lastGameRoadLogo: flamingosLogo, lastGameHomeLogo: skylarksSecondaryLogo, nextGame: widgetPreviewLastGame, nextGameOpponentLogo: sluggersLogo, skylarksAreRoadTeam: false, Table: userDashboard.leagueTable, TableRow: userDashboard.tableRow)
    }

    func getSnapshot(for configuration: FavoriteTeamIntent, in context: Context, completion: @escaping (FavoriteTeamEntry) -> ()) {
        //this method provides the data for the preview in the widget gallery
        let entry = FavoriteTeamEntry(date: Date(), configuration: FavoriteTeamIntent(), team: widgetPreviewTeam, lastGame: widgetPreviewLastGame, lastGameRoadLogo: flamingosLogo, lastGameHomeLogo: skylarksSecondaryLogo, nextGame: widgetPreviewLastGame, nextGameOpponentLogo: sluggersLogo, skylarksAreRoadTeam: false, Table: userDashboard.leagueTable, TableRow: userDashboard.tableRow)
        completion(entry)
    }

    func getTimeline(for configuration: FavoriteTeamIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        Task {
            let selectedTeam = await team(for: configuration)
            
            //MARK: DEBUG
            // first we load the tables to infer the league ID for scores
            
            let leagueGroups = await loadLeagueGroups(season: season)
            
            userDashboard.leagueTable = await loadTableForTeam(team: selectedTeam, leagueGroups: leagueGroups)
            userDashboard.tableRow = determineTableRow(team: selectedTeam, table: userDashboard.leagueTable)
            
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
            var lastGameRoadLogo = away_team_logo
            var lastGameHomeLogo = home_team_logo
            
            var nextGameRoadLogo = away_team_logo
            var nextGameHomeLogo = home_team_logo
            
            var nextGameOpponentLogo = away_team_logo
            
            var skylarksAreRoadTeam = false
            
            //check for last game
            if let lastGame = displayGames.last {
                let logos = fetchCorrectLogos(gamescore: lastGame)
                lastGameRoadLogo = logos.road
                lastGameHomeLogo = logos.home
            }
            
            //check for next game
            if let nextGame = displayGames.next {
                let logos = fetchCorrectLogos(gamescore: nextGame)
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

            // Generate a timeline consisting of 3 entries an hour apart, starting from the current date. WAS FIVE!
            let currentDate = Date()
            for hourOffset in 0 ..< 2 {
                let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
                let entry = FavoriteTeamEntry(date: entryDate, configuration: configuration, team: selectedTeam, lastGame: displayGames.last, lastGameRoadLogo: lastGameRoadLogo, lastGameHomeLogo: lastGameHomeLogo, nextGame: displayGames.next, nextGameOpponentLogo: nextGameOpponentLogo, skylarksAreRoadTeam: skylarksAreRoadTeam, Table: userDashboard.leagueTable, TableRow: userDashboard.tableRow)
                entries.append(entry)
            }

            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
            
                
                // MARK: nested completion handlers work => but I should explore better options here, it is widely considered to be unreadable code!
                //WIP: change to async/await
                
//                loadBSMData(url: team1.leagueTableURL, dataType: LeagueTable.self) { loadedTable in
//                    userDashboard.leagueTable = loadedTable
//
//                    for row in userDashboard.leagueTable.rows where row.team_name.contains("Skylarks") {
//
//                        //we have two teams for BZL, so the function needs to account for the correct one
////                        if selectedTeam == team3 {
////                            if row.team_name == "Skylarks 3" {
////                                userDashboard.tableRow = row
////                            }
////                        } else if selectedTeam == team4 {
////                            if row.team_name == "Skylarks 4" {
////                                userDashboard.tableRow = row
////                            }
////                        } else if selectedTeam != team3 && selectedTeam != team4 {
//                            userDashboard.tableRow = row
////                        }
//                    }
                    
    }
}

struct FavoriteTeamEntry: TimelineEntry {
    let date: Date
    let configuration: FavoriteTeamIntent
    let team: BSMTeam
    let lastGame: GameScore?
    let lastGameRoadLogo: Image
    let lastGameHomeLogo: Image
    let nextGame: GameScore?
    let nextGameOpponentLogo: Image
    let skylarksAreRoadTeam: Bool
    let Table: LeagueTable
    let TableRow: LeagueTable.Row
}

struct WidgetSkylarksEntryView : View {
    var entry: FavoriteTeamProvider.Entry

    var body: some View {
        FavoriteTeamWidgetView(entry: entry)
    }
}

@main
struct WidgetSkylarks: Widget {
    let kind: String = "WidgetSkylarks"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: FavoriteTeamIntent.self, provider: FavoriteTeamProvider()) { entry in
            WidgetSkylarksEntryView(entry: entry)
        }
        .configurationDisplayName("Team Overview")
        .description("Shows info about your favorite Skylarks team.")
        
        //TODO: add support for extraLarge
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

//struct WidgetSkylarks_Previews: PreviewProvider {
//    static var previews: some View {
//        WidgetSkylarksEntryView(entry: FavoriteTeamEntry(date: Date(), configuration: FavoriteTeamIntent(), team: team1))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
