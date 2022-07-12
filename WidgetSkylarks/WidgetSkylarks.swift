//
//  WidgetSkylarks.swift
//  WidgetSkylarks
//
//  Created by David Battefeld on 21.12.21.
//

import WidgetKit
import SwiftUI
import Intents

struct GamedayWidget: Widget {
    let kind: String = "GamedayWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: GamedayTimeline()) { entry in
            GamedayWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Gameday Overview")
        .description("Shows all games on the current gameday")
        
        .supportedFamilies([.systemLarge, .systemExtraLarge])
    }
}

struct FavoriteTeamWidget: Widget {
    let kind: String = "FavoriteTeamWidget"

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

@main
struct SkylarksWidgetBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        FavoriteTeamWidget()
        GamedayWidget()
    }
}
