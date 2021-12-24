//
//  GamedayWidgetView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 23.12.21.
//

import SwiftUI
import WidgetKit

struct GamedayWidgetView: View {
    
    //var gamescore: GameScore
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        
        switch widgetFamily {
        case .systemMedium:
            Text("MEDIUM")
        case .systemSmall:
            ZStack {
                //LinearGradient(colors: [Color.skylarksBlue, Color.skylarksRed], startPoint: .topLeading, endPoint: .bottomTrailing)
                Color(UIColor.systemBackground)
                //Color.skylarksBlue
                HStack {
                    VStack(alignment: .leading) {
                        Text("Scores")
                            .font(Font.callout.smallCaps())
                            .foregroundColor(Color.skylarksRed)
                        //Divider()
                        VStack(alignment: .leading) {
                            HStack {
    //                            Image("Bird_whiteoutline")
    //                                .resizable()
    //                                .scaledToFit()
                                Text("BEA")
                                Spacer()
                                Text("12")
                                    .bold()
                            }
                            .font(.caption)
                            HStack {
    //                            Image("Sluggers_Logo")
    //                                .resizable()
    //                                .scaledToFit()
                                Text("BES2")
                                Spacer()
                                Text("11")
                                    .bold()
                            }
                            .font(.caption)
                        }
                        .padding(.all, 3.0)
                        .background(ContainerRelativeShape().fill(Color(UIColor.tertiarySystemFill)))
                        VStack(alignment: .leading) {
                            HStack {
    //                            Image("Bird_whiteoutline")
    //                                .resizable()
    //                                .scaledToFit()
                                Text("BEA")
                                Spacer()
                                Text("8")
                                    .bold()
                            }
                            .font(.caption)
                            HStack {
    //                            Image("Sluggers_Logo")
    //                                .resizable()
    //                                .scaledToFit()
                                Text("BES2")
                                Spacer()
                                Text("6")
                                    .bold()
                            }
                            .font(.caption)
                        }
                        .padding(.all, 3.0)
                        .background(ContainerRelativeShape().fill(Color(UIColor.tertiarySystemFill)))
                    }
                    Spacer()
                    
                }
                .padding()
            }
        case .systemLarge:
            Text("dbfbfd")
        case .systemExtraLarge:
            Text("kdfbnhg")
        @unknown default:
            Text("default")
        }
        
    }
}

struct GamedayWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GamedayWidgetView()
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                //.environment(\.colorScheme, .dark)
            GamedayWidgetView()
                .previewContext(WidgetPreviewContext(family: .systemMedium))
//            GamedayWidgetView(gamescore: dummyGameScores[5])
//                .previewContext(WidgetPreviewContext(family: .systemMedium))
//            GamedayWidgetView(gamescore: dummyGameScores[5])
//                .previewContext(WidgetPreviewContext(family: .systemLarge))
//            GamedayWidgetView(gamescore: dummyGameScores[5])
//                .previewContext(WidgetPreviewContext(family: .systemExtraLarge))
        }
        
    }
}
