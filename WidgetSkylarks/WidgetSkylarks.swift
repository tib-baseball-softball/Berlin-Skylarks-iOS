//
//  WidgetSkylarks.swift
//  WidgetSkylarks
//
//  Created by David Battefeld on 21.12.21.
//

import WidgetKit
import SwiftUI
import Intents

#if !os(macOS)
struct TeamLogoWidget: Widget {
    let kind = "LogoWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TeamLogoProvider()) { entry in
            TeamLogoEntryView(entry: entry)
        }
        .configurationDisplayName("Team Logo")
        .description("Show off your team pride with the Skylarks team logo")
        .supportedFamilies([.accessoryCircular])
    }
}
#endif

#if !os(watchOS)
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
        
        //MARK: add support for extraLarge
        
        #if !os(macOS)
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge, .accessoryInline, .accessoryCircular, .accessoryRectangular])
        #else
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
        #endif
    }
}
#endif

@main
struct SkylarksWidgetBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
#if !os(watchOS)
        FavoriteTeamWidget()
        //GamedayWidget()
#endif
        //MARK: comment me back in when loading the image on a physical watch works
        //TeamLogoWidget()
    }
}
