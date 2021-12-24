//
//  FavoriteTeamWidgetView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 23.12.21.
//

import SwiftUI
import WidgetKit

struct FavoriteTeamWidgetView: View {
    
    @Environment(\.widgetFamily) var widgetFamily
    //var gamescore: GameScore
    
    var body: some View {
        ZStack {
            //LinearGradient(colors: [Color.skylarksBlue, Color.skylarksRed], startPoint: .topLeading, endPoint: .bottomTrailing)
            Color(UIColor.systemBackground)
            //Color.skylarksBlue
            HStack(alignment: .top) {
                TeamWidgetLastGameView()
                
                if widgetFamily != .systemSmall {
                    Divider()
                        .padding(.vertical)
                    TeamWidgetNextGameView()
                }
            }
        }
    }
}

struct FavoriteTeamWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FavoriteTeamWidgetView()
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                //.environment(\.colorScheme, .dark)
            FavoriteTeamWidgetView()
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                //.environment(\.colorScheme, .dark)
            FavoriteTeamWidgetView()
                .previewContext(WidgetPreviewContext(family: .systemLarge))
                //.environment(\.colorScheme, .dark)
            FavoriteTeamWidgetView()
                .previewContext(WidgetPreviewContext(family: .systemExtraLarge))
                //.environment(\.colorScheme, .dark)
        }
        
    }
}


struct TeamWidgetLastGameView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 0.5) {
                    Text("Team 1")
                        .foregroundColor(Color.skylarksRed)
                    Text("Latest Score")
                        .font(.caption)
                }
                Spacer()
                Text("W")
                    .foregroundColor(.green)
                    .bold()
            }
            .font(Font.callout.smallCaps())
            Divider()
            VStack(alignment: .leading, spacing: 0.0) {
                HStack {
                    Image("Bird_whiteoutline")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 35)
                    Text("BEA")
                    Spacer()
                    Text("12")
                        .font(.headline)
                        .bold()
                }
                .padding(.vertical, 2)
                HStack {
                    Image("Sluggers_Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 35)
                    Text("BES2")
                    Spacer()
                    Text("11")
                        .font(.headline)
                        .bold()
                }
                .padding(.vertical,2)
            }
            
            .padding(.all, 3.0)
            .background(ContainerRelativeShape().fill(Color(UIColor.systemBackground)))
            //.border(Color.skylarksSand)
            //Divider()
        }.font(.subheadline)
        .padding()
    }
}

struct TeamWidgetNextGameView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 0.5) {
                    Text("Team 1")
                        .foregroundColor(Color.skylarksRed)
                    Text("Next Game")
                        .font(.caption)
                }
                Spacer()
                VStack(spacing: 2) {
                    Image(systemName: "clock")
                        .foregroundColor(.skylarksRed)
                    Text("12:00")
                }
                .font(.caption)
            }
            .font(Font.callout.smallCaps())
            Divider()
            VStack(alignment: .leading, spacing: 2.0) {
                HStack {
                    Image("Berlin_Flamingos_Logo_3D")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 28)
                    Text("Flamingos 2")
                    Spacer()
                }
                HStack {
                    Image(systemName: "calendar")
                        .font(.callout)
                        .foregroundColor(.skylarksSand)
                    Text("2. Oktober 2021")
                }
            }
            .font(.subheadline)
            .background(ContainerRelativeShape().fill(Color(UIColor.systemBackground)))
        }.font(.subheadline)
        .padding()
    }
}

