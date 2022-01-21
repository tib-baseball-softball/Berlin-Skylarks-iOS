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
    
    func team(for configuration: FavoriteTeamIntent) -> SkylarksTeam {
        switch configuration.team {
        case .team1:
            return team1
        case .team2:
            return team2
        case .team3:
            return team3
        case .team4:
            return team4
        case .teamSoftball:
            return teamSoftball
        case .teamJugend:
            return teamJugend
        case .teamSchueler:
            return teamSchueler
        case .teamTossball:
            return teamTossball
            //TODO: add team!
        case .teamTeeball:
            return teamTossball
        default:
            return team1
        }
    }
    
    func placeholder(in context: Context) -> FavoriteTeamEntry {
        FavoriteTeamEntry(date: Date(), configuration: FavoriteTeamIntent(), team: team1, lastGame: testGame, lastGameRoadLogo: away_team_logo, lastGameHomeLogo: home_team_logo, nextGame: testGame, nextGameOpponentLogo: away_team_logo, skylarksAreRoadTeam: false, Table: userDashboard.leagueTable, TableRow: userDashboard.tableRow)
    }

    func getSnapshot(for configuration: FavoriteTeamIntent, in context: Context, completion: @escaping (FavoriteTeamEntry) -> ()) {
        //TODO: check what this method does
        let entry = FavoriteTeamEntry(date: Date(), configuration: configuration, team: team1, lastGame: testGame, lastGameRoadLogo: away_team_logo, lastGameHomeLogo: home_team_logo, nextGame: testGame, nextGameOpponentLogo: away_team_logo, skylarksAreRoadTeam: false, Table: userDashboard.leagueTable, TableRow: userDashboard.tableRow)
        completion(entry)
    }

    func getTimeline(for configuration: FavoriteTeamIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        let selectedTeam = team(for: configuration)
        //var gamescore = testGame //I should really experiment with an empty init at some point in the future
        
        loadGameScoreData(url: selectedTeam.scoresURL) { gamescores in
            let displayGames = processGameDates(gamescores: gamescores)
            
            var lastGameRoadLogo = away_team_logo
            var lastGameHomeLogo = home_team_logo
            
            var nextGameRoadLogo = away_team_logo
            var nextGameHomeLogo = home_team_logo
            
            var nextGameOpponentLogo = away_team_logo
            
            var skylarksAreRoadTeam = false
            
            if let lastGame = displayGames.last {
                let logos = fetchCorrectLogos(gamescore: lastGame)
                lastGameRoadLogo = logos.road
                lastGameHomeLogo = logos.home
            }
            
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
            
            // let's see if nested completion handlers work => they do, but I should explore better options here, it is widely considered to be unreadable code!
            
            //let userDashboard = UserDashboard() //moved to top of struct
            
            loadTableData(url: selectedTeam.leagueTableURL) { loadedTable in
                userDashboard.leagueTable = loadedTable
                
                for row in userDashboard.leagueTable.rows where row.team_name.contains("Skylarks") {
                    
                    //we have two teams for BZL, so the function needs to account for the correct one
                    if selectedTeam == team3 {
                        if row.team_name == "Skylarks 3" {
                            userDashboard.tableRow = row
                        }
                    } else if selectedTeam == team4 {
                        if row.team_name == "Skylarks 4" {
                            userDashboard.tableRow = row
                        }
                    } else if selectedTeam != team3 && selectedTeam != team4 {
                        userDashboard.tableRow = row
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
        }
    }
}

struct FavoriteTeamEntry: TimelineEntry {
    let date: Date
    let configuration: FavoriteTeamIntent
    let team: SkylarksTeam
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
