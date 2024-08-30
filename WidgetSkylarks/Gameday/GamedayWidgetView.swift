//
//  GamedayWidgetView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 23.12.21.
//

import SwiftUI
import WidgetKit

struct GamedayWidgetView: View {
    
    var entry: GamedayTimeline.Entry
    
    @Environment(\.widgetFamily) var widgetFamily
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            //LinearGradient(colors: [Color.skylarksBlue, Color.skylarksRed], startPoint: .topLeading, endPoint: .bottomTrailing)
            //Color(colorScheme == .light ? .secondarySystemBackground : .systemBackground)
            //Color.skylarksBlue
            //Color.skylarksRed
            VStack(alignment: .leading) {
                //Text(entry.gamescores.debugDescription)
                HStack {
                    Text("Scores")
                        .font(Font.headline.smallCaps())
                        .foregroundColor(Color.skylarksRed)
                    //.shadow(color: .white, radius: 15)
                    Spacer()
                    Text("Current Gameday")
                        .font(Font.subheadline.smallCaps())
                        //.foregroundColor(.skylarksDynamicNavySand)
                }
                Divider()
                    .foregroundColor(.skylarksDynamicNavySand)
                LazyVGrid(columns: [GridItem(.adaptive(minimum: widgetFamily == .systemExtraLarge ? 130 : 90))], spacing: 10) {
                    ForEach(entry.gamescores) { gamescore in
                        GamedayTeamBlock(gamescore: gamescore)
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct GamedayWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GamedayWidgetView(entry: GamedayEntry(date: Date(), gamescores: [testGame, testGame]))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
            GamedayWidgetView(entry: GamedayEntry(date: Date(), gamescores: [testGame, testGame]))
                .previewContext(WidgetPreviewContext(family: .systemExtraLarge))
        }
    }
}
