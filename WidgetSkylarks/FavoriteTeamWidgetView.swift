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
    
    var body: some View {
        ZStack {
            //LinearGradient(colors: [Color.skylarksBlue, Color.skylarksRed], startPoint: .topLeading, endPoint: .bottomTrailing)
            Color(UIColor.systemBackground)
            //Color.skylarksBlue
            VStack {
                
                //MARK: this is needed because of error in preview, real code below
                //if widgetFamily == .systemMedium {
                if widgetFamily == .systemLarge || widgetFamily == .systemExtraLarge {
                    
                    //TODO: this needs a parameter to account for the team later
                    
                    TeamWidgetOverView(entry: entry)
                    Divider()
                        .padding(.horizontal)
                }
                
                HStack(alignment: .top) {
                    
                    TeamWidgetLastGameView(entry: entry)
                    
                    if widgetFamily != .systemSmall {
                        Divider()
                            .padding(.vertical)
                        TeamWidgetNextGameView(entry: entry) //MARK: this is obviously WIP
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
//            FavoriteTeamWidgetView(entry: )
//                .previewContext(WidgetPreviewContext(family: .systemLarge))
//                .environment(\.colorScheme, .dark)
//            FavoriteTeamWidgetView()
//                .previewContext(WidgetPreviewContext(family: .systemExtraLarge))
//                .environment(\.colorScheme, .dark)
        }
        
    }
}


struct TeamWidgetLastGameView: View {
    
    var entry: FavoriteTeamProvider.Entry
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 0.5) {
                    Text(entry.team.name)
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
                    away_team_logo
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 35)
                    Text(entry.lastGame.away_league_entry.team.short_name)
                    Spacer()
                    if let awayScore = entry.lastGame.away_runs {
                        Text(String(awayScore))
                            .font(.headline)
                            .bold()
                            .foregroundColor(entry.lastGame.away_team_name.contains("Skylarks") ? Color.skylarksRed : Color.primary)
                    }
                }
                .padding(.vertical, 2)
                HStack {
                    home_team_logo
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 35)
                    Text(entry.lastGame.home_league_entry.team.short_name)
                    Spacer()
                    if let homeScore = entry.lastGame.home_runs {
                        Text(String(homeScore))
                            .font(.headline)
                            .bold()
                            .foregroundColor(entry.lastGame.home_team_name.contains("Skylarks") ? Color.skylarksRed : Color.primary)
                    }
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
    
    var entry: FavoriteTeamProvider.Entry
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 0.5) {
                    Text(entry.team.name)
                        .bold()
                        .foregroundColor(Color.skylarksRed)
                    Text("Next Game")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                Spacer()
                VStack(spacing: 2) {
                    Image(systemName: "clock")
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
    
    var entry: FavoriteTeamProvider.Entry
    
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
                        Text(entry.team.name)
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
                            .frame(maxWidth: 20)
                        Text(entry.team.leagueName)
                    }
                    HStack {
                        Image(systemName: "calendar.badge.clock")
                            .frame(maxWidth: 20)
                        Text("2021")
                    }
                    Spacer()
                    Group {
                        HStack {
                            Image(systemName: "sum")
                                .frame(maxWidth: 20)
                            Text("14 : 2")
                                .bold()
                        }
                        HStack {
                            Image(systemName: "percent")
                                .frame(maxWidth: 20)
                            Text(".875")
                                .bold()
                        }
                        HStack {
                            Image(systemName: "number")
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
