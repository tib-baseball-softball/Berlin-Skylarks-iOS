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
                
                //MARK: this is needed because of error in preview
                //if widgetFamily == .systemMedium {
                //MARK: real code
                if widgetFamily == .systemLarge || widgetFamily == .systemExtraLarge {
                    
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

struct TeamWidgetLastGameView: View {
    
    var entry: FavoriteTeamProvider.Entry
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 0.5) {
                    if !entry.team.league_entries.isEmpty {
                        Text(entry.team.league_entries[0].league.acronym)
                            .bold()
                            .foregroundColor(Color.skylarksRed)
                    } else {
                        Text("NOL")
                    }
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
                    if let awayScore = lastGame.away_runs, let homeScore = lastGame.home_runs {
                        Text(String(awayScore))
                            .font(.headline)
                            .bold()
                            .foregroundColor(awayScore < homeScore ? Color.secondary : Color.primary)
                            //was hidden on Mac, watch if this helps
                            .layoutPriority(1)
                    }
                }
                .padding(.vertical, 1.5)
                HStack {
                    entry.lastGameHomeLogo
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 35, maxHeight: 35)
                    Text(lastGame.home_league_entry.team.short_name)
                    Spacer()
                    if let awayScore = lastGame.away_runs, let homeScore = lastGame.home_runs {
                        Text(String(homeScore))
                            .font(.headline)
                            .bold()
                            .foregroundColor(awayScore > homeScore ? Color.secondary : Color.primary)
                            .layoutPriority(1)
                    }
                }
                .padding(.vertical, 1.5)
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
            HStack {
                VStack(alignment: .leading, spacing: 0.5) {
                    if !entry.team.league_entries.isEmpty {
                        Text(entry.team.league_entries[0].league.acronym)
                            .bold()
                            .foregroundColor(Color.skylarksRed)
                    } else {
                        Text("NOL")
                    }
                    Text("Next Game")
                        .lineLimit(1)
                        .fixedSize()
                        //.scaledToFill()
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                Spacer()
                VStack(spacing: 2) {
                    Image(systemName: "clock")
                    if let gameTime = entry.nextGame?.gameDate {
                        Text(gameTime, style: .time)
                            //.scaledToFill()
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
                        .frame(maxWidth: 35, minHeight: 30, maxHeight: 35)
                    if entry.skylarksAreRoadTeam == true {
                        Text(nextGame.home_league_entry.team.short_name)
                    }
                    if entry.skylarksAreRoadTeam == false {
                        Text(nextGame.away_league_entry.team.short_name)
                    }
                    Spacer()
                }
                //.padding(.top, 5.0)
                HStack {
                    Image(systemName: "calendar")
                        .frame(maxWidth: 35)
                        .font(.callout)
                    if let gameDate = nextGame.gameDate {
                        Text(gameDate, format: Date.FormatStyle().day().month().year())
                            .scaledToFill()
                            //.fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            //.padding(.top,2)
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
                        Text(entry.team.league_entries[0].league.acronym)
                    }
                    HStack {
                        Image(systemName: "calendar.badge.clock")
                            .frame(maxWidth: 20)
                        Text(String(entry.Table.season))
                    }
                    Spacer()
                    Group {
                        HStack {
                            Image(systemName: "sum")
                                .frame(maxWidth: 20)
                            Text(String(entry.TableRow.wins_count) + "-" + String(entry.TableRow.losses_count))
                                .bold()
                        }
                        HStack {
                            Image(systemName: "percent")
                                .frame(maxWidth: 20)
                            Text(entry.TableRow.quota)
                                .bold()
                        }
                        HStack {
                            Image(systemName: "number")
                                .frame(maxWidth: 20)
                            Text(entry.TableRow.rank)
                                .bold()
                            if entry.TableRow.rank == "1." {
                                Image(systemName: "crown")
                                    .foregroundColor(Color.skylarksRed)
                            }
                        }
                    }
                }
                .frame(minWidth: 120)
                .padding([.top, .bottom, .trailing])
                .background(ContainerRelativeShape().fill(Color(UIColor.secondarySystemBackground)))
                .font(.subheadline)
            }
            .font(Font.body.smallCaps())
        }
        .font(.subheadline)
        .padding()
    }
}

struct FavoriteTeamWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyDashboard = UserDashboard()
        Group {
              FavoriteTeamWidgetView(entry: FavoriteTeamEntry(date: Date(), configuration: FavoriteTeamIntent(), team: widgetPreviewTeam, lastGame: widgetPreviewLastGame, lastGameRoadLogo: flamingosLogo, lastGameHomeLogo: skylarksSecondaryLogo, nextGame: widgetPreviewNextGame, nextGameOpponentLogo: sluggersLogo, skylarksAreRoadTeam: false, Table: dummyDashboard.leagueTable, TableRow: dummyDashboard.tableRow))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                //.environment(\.colorScheme, .dark)
            FavoriteTeamWidgetView(entry: FavoriteTeamEntry(date: Date(), configuration: FavoriteTeamIntent(), team: widgetPreviewTeam, lastGame: widgetPreviewLastGame, lastGameRoadLogo: flamingosLogo, lastGameHomeLogo: skylarksSecondaryLogo, nextGame: widgetPreviewNextGame, nextGameOpponentLogo: sluggersLogo, skylarksAreRoadTeam: false, Table: dummyDashboard.leagueTable, TableRow: dummyDashboard.tableRow))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                //.environment(\.colorScheme, .dark)
            FavoriteTeamWidgetView(entry: FavoriteTeamEntry(date: Date(), configuration: FavoriteTeamIntent(), team: widgetPreviewTeam, lastGame: widgetPreviewLastGame, lastGameRoadLogo: flamingosLogo, lastGameHomeLogo: skylarksSecondaryLogo, nextGame: widgetPreviewNextGame, nextGameOpponentLogo: sluggersLogo, skylarksAreRoadTeam: false, Table: dummyDashboard.leagueTable, TableRow: dummyDashboard.tableRow))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
                //.environment(\.colorScheme, .dark)
        }
    }
}
