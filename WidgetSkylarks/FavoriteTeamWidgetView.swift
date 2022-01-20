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
            FavoriteTeamWidgetView(entry: FavoriteTeamEntry(date: Date(), configuration: FavoriteTeamIntent(), team: team1, lastGame: testGame, lastGameRoadLogo: away_team_logo, lastGameHomeLogo: home_team_logo, nextGame: testGame, nextGameOpponentLogo: away_team_logo, skylarksAreRoadTeam: false))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .environment(\.colorScheme, .dark)
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
                Image(systemName: "star.fill")
                    .foregroundColor(.skylarksSand)
                    .font(.caption)
                    .offset(y: 2)
            }
            .font(Font.callout.smallCaps())
            
            Divider()
            
            if let lastGame = entry.lastGame {
            VStack(alignment: .leading, spacing: 0.0) {
                HStack {
                    entry.lastGameRoadLogo
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 35, maxHeight: 35)
                    Text(lastGame.away_league_entry.team.short_name)
                    Spacer()
                    if let awayScore = lastGame.away_runs {
                        Text(String(awayScore))
                            .font(.headline)
                            .bold()
                            .foregroundColor(lastGame.away_team_name.contains("Skylarks") ? Color.skylarksRed : Color.primary)
                    }
                }
                .padding(.vertical, 2)
                HStack {
                    entry.lastGameHomeLogo
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 35, maxHeight: 35)
                    Text(lastGame.home_league_entry.team.short_name)
                    Spacer()
                    if let homeScore = lastGame.home_runs {
                        Text(String(homeScore))
                            .font(.headline)
                            .bold()
                            .foregroundColor(lastGame.home_team_name.contains("Skylarks") ? Color.skylarksRed : Color.primary)
                    }
                }
                .padding(.vertical,2)
            }
            .background(ContainerRelativeShape().fill(Color(UIColor.systemBackground)))
            //.border(Color.skylarksSand)
            //Divider()
            } else {
                Text("There is no last game to display.")
                    .font(.subheadline)
            }
        }
        .font(.subheadline)
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
                    if let gameTime = entry.nextGame?.gameDate {
                        Text(gameTime, style: .time)
                    }
                }
                .font(.footnote)
            }
            .font(Font.callout.smallCaps())
            //.padding(.bottom, 2)
            
            Divider()
            
            if let nextGame = entry.nextGame {
            VStack(alignment: .leading, spacing: 10.0) {
                HStack {
                    entry.nextGameOpponentLogo
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 35)
                    if entry.skylarksAreRoadTeam == true {
                        Text(nextGame.home_team_name)
                    }
                    if entry.skylarksAreRoadTeam == false {
                        Text(nextGame.away_team_name)
                    }
                    Spacer()
                }
                .padding(.top, 5.0)
                HStack {
                    Image(systemName: "calendar")
                        .frame(maxWidth: 35)
                        .font(.callout)
                    if let gameDate = nextGame.gameDate {
                        Text(gameDate, style: .date)
                    }
                }
            }
            .padding(.vertical,2)
            .font(.subheadline)
            .background(ContainerRelativeShape().fill(Color(UIColor.systemBackground)))
            } else {
                Text("There is no next game to display.")
                    .font(.subheadline)
            }
        }
        .font(.subheadline)
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
