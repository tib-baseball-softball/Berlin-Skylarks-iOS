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
        FavoriteTeamEntry(date: Date(), configuration: FavoriteTeamIntent(), team: team1, lastGame: testGame)
    }

    func getSnapshot(for configuration: FavoriteTeamIntent, in context: Context, completion: @escaping (FavoriteTeamEntry) -> ()) {
        //TODO: check what this method does
        let entry = FavoriteTeamEntry(date: Date(), configuration: configuration, team: team1, lastGame: testGame)
        completion(entry)
    }

    func getTimeline(for configuration: FavoriteTeamIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        let selectedTeam = team(for: configuration)
        
        let gamescores = loadGameScoreData(url: selectedTeam.scoresURL)
        let gamescore = getNextGame(gamescores: gamescores)
        
        var entries: [FavoriteTeamEntry] = []

        // Generate a timeline consisting of two entries an hour apart, starting from the current date. WAS FIVE!
        let currentDate = Date()
        for hourOffset in 0 ..< 1 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = FavoriteTeamEntry(date: entryDate, configuration: configuration, team: selectedTeam, lastGame: gamescore)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    func getNextGame(gamescores: [GameScore]) -> GameScore {
        if gamescores != [] {
            return gamescores[0]
        }
        else {
            return testGame
        }
    }
}

struct FavoriteTeamEntry: TimelineEntry {
    let date: Date
    let configuration: FavoriteTeamIntent
    let team: SkylarksTeam
    let lastGame: GameScore
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
