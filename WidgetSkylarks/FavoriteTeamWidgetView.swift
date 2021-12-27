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
    
    var entry: FavoriteTeamProvider.Entry
    //var gamescore: GameScore
    
    var body: some View {
        ZStack {
            //LinearGradient(colors: [Color.skylarksBlue, Color.skylarksRed], startPoint: .topLeading, endPoint: .bottomTrailing)
            Color(UIColor.systemBackground)
            //Color.skylarksBlue
            VStack {
                
                //TODO: this is needed because of error in preview, real code below
                //if widgetFamily == .systemMedium {
                if widgetFamily == .systemLarge || widgetFamily == .systemExtraLarge {
                    TeamWidgetOverView()
                    Divider()
                        .padding(.horizontal)
                }
                
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
}

struct FavoriteTeamWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
//            FavoriteTeamWidgetView()
//                .previewContext(WidgetPreviewContext(family: .systemSmall))
//                .environment(\.colorScheme, .dark)
//            FavoriteTeamWidgetView()
//                .previewContext(WidgetPreviewContext(family: .systemMedium))
//                .environment(\.colorScheme, .dark)
            FavoriteTeamWidgetView(entry: FavoriteTeamEntry(date: Date(), configuration: FavoriteTeamIntent()))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
                //.environment(\.colorScheme, .dark)
//            FavoriteTeamWidgetView()
//                .previewContext(WidgetPreviewContext(family: .systemExtraLarge))
//                .environment(\.colorScheme, .dark)
        }
        
    }
}


struct TeamWidgetLastGameView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 0.5) {
                    Text("Team 1")
                        .bold()
                        .foregroundColor(Color.skylarksRed)
                    Text("Latest Score")
                        .font(.footnote)
                        .foregroundColor(.secondary)
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
                        .bold()
                        .foregroundColor(Color.skylarksRed)
                    Text("Next Game")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                Spacer()
                VStack(spacing: 2) {
                    Image(systemName: "clock")
                        .foregroundColor(.skylarksRed)
                    Text("12:00")
                }
                .font(.footnote)
            }
            .font(Font.callout.smallCaps())
            //.padding(.bottom, 2)
            
            Divider()
            
            VStack(alignment: .leading, spacing: 10.0) {
                HStack {
                    Image("Berlin_Flamingos_Logo_3D")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 35)
                    Text("FLA")
                    Spacer()
                }
                .padding(.top, 5.0)
                HStack {
                    Image(systemName: "calendar")
                        .frame(maxWidth: 35)
                        .font(.callout)
                        .foregroundColor(.skylarksRed)
                    Text("02.10.2021")
                }
            }
            .padding(.vertical,2)
            .font(.subheadline)
            .background(ContainerRelativeShape().fill(Color(UIColor.systemBackground)))
        }.font(.subheadline)
            .padding()
    }
}

struct TeamWidgetOverView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 0.5) {
                    Image("Rondell")
                        .resizable()
                        .scaledToFit()
                    Spacer()
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.skylarksRed)
                        Text("Team 1")
                            .bold()
                        .foregroundColor(Color.skylarksRed)
                    }
                    
                    Text("Standings")
                        .font(.subheadline)
                        .foregroundColor(.skylarksSand)
                    
                }
                Spacer()
                VStack(alignment: .leading, spacing: 3) {
                    HStack {
                        Image(systemName: "tablecells")
                            .foregroundColor(.skylarksRed)
                            .frame(maxWidth: 20)
                        Text("Verbandsliga")
                    }
                    HStack {
                        Image(systemName: "calendar.badge.clock")
                            .foregroundColor(.skylarksRed)
                            .frame(maxWidth: 20)
                        Text("2021")
                    }
                    Spacer()
                    Group {
                        HStack {
                            Image(systemName: "sum")
                                .foregroundColor(.skylarksRed)
                                .frame(maxWidth: 20)
                            Text("14 : 2")
                                .bold()
                        }
                        HStack {
                            Image(systemName: "percent")
                                .foregroundColor(.skylarksRed)
                                .frame(maxWidth: 20)
                            Text(".875")
                                .bold()
                        }
                        HStack {
                            Image(systemName: "number")
                                .foregroundColor(.skylarksRed)
                                .frame(maxWidth: 20)
                            Text("1.")
                                .bold()
                        }
                    }
                }
                .padding()
                .background(ContainerRelativeShape().fill(Color(UIColor.secondarySystemBackground)))
                .font(.subheadline)
            }
            .font(Font.body.smallCaps())
        }
        .font(.subheadline)
        .padding()
    }
}
