//
//  ScoresOverView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 27.12.20.
//

import SwiftUI

struct ScoresOverView: View {
    
    var gamescore: GameScore
    
    @State var roadLogo = away_team_logo
    @State var homeLogo = home_team_logo
    
    func setLogos() {
        let logos = fetchCorrectLogos(gamescore: gamescore)
        roadLogo = logos.road
        homeLogo = logos.home
    }
    
    var body: some View {
        #if !os(watchOS)
        determineGameStatus(gamescore: gamescore)
        return
            VStack(spacing: ScoresItemSpacing) {
                VStack {
                    Text(gamescore.league.name)
                        .font(.title3)
                        .bold()
                    HStack {
                        VStack(alignment: .leading, spacing: 7) {
                            HStack {
                                Image(systemName: "calendar")
                                if let date = gamescore.gameDate {
                                    Text(date, style: .date)
                                }
                            }
                            HStack {
                                Image(systemName: "clock.fill")
                                if let time = gamescore.gameDate {
                                    Text(time, style: .time)
                                }
                            }
                        }
                        .padding()
                        Spacer()
                        Divider()
                            .frame(height: 40)
                        Spacer()
                        GameResultIndicator(gamescore: gamescore)
                        Spacer()
                    }
                    
                }
                HStack {
                    HStack {
                        //away_team_logo
                        roadLogo
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50, alignment: .center)
                        Text(gamescore.away_team_name)
                            .padding(.leading)
                    }
                    Spacer()
                    if let awayScore = gamescore.away_runs {
                        Text(String(awayScore))
                            .font(.largeTitle)
                            .bold()
                            .padding(.horizontal)
                            .foregroundColor(gamescore.away_team_name.contains("Skylarks") ? Color.accentColor : Color.primary)
                    }
                    
                }
                .padding()
                .background(ScoresSubItemBackground)
                .cornerRadius(NewsItemCornerRadius)
                HStack {
                    HStack {
                        homeLogo
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50, alignment: .center)
                        Text(gamescore.home_team_name)
                            .padding(.leading)
                    }
                    Spacer()
                    
                    if let homeScore = gamescore.home_runs {
                        Text(String(homeScore))
                            .font(.largeTitle)
                            .bold()
                            .padding(.horizontal)
                            .foregroundColor(gamescore.home_team_name.contains("Skylarks") ? Color.accentColor : Color.primary)
                    }
                }
                .padding()
                .background(ScoresSubItemBackground)
                .cornerRadius(NewsItemCornerRadius)
        }
        .padding()
        .background(.regularMaterial) //switch on or off depending on whether I use List or Grid
        .cornerRadius(NewsItemCornerRadius)
        
        .onAppear(perform: {
            setLogos()
        })
        #endif
        
        //---------------------------------------------------------//
        //-----------start Apple Watch-specific code---------------//
        //---------------------------------------------------------//
        
        #if os(watchOS)
        determineGameStatus(gamescore: gamescore)
        return
            VStack {
                VStack {
                    Text(gamescore.league.name)
                        .font(.caption2)
                    if let gameDate = gamescore.gameDate {
                        HStack {
                            Text(gameDate, style: .date)
                            Text(gameDate, style: .time)
                        }
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    }
                    Divider()
                        .padding(.horizontal)
                    HStack {
                        roadLogo
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 30, alignment: .center)
                        Text(gamescore.away_league_entry.team.short_name)
                            .font(.caption)
                            .padding(.leading)
                        Spacer()
                        if let awayScore = gamescore.away_runs {
                            Text(String(awayScore))
                                .font(.title3)
                                .bold()
                                .frame(maxWidth: 40, alignment: .center)
                                .foregroundColor(gamescore.away_team_name.contains("Skylarks") ? Color.accentColor : Color.primary)
                        }
                    }
                    HStack {
                        homeLogo
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 30, alignment: .center)
                        Text(gamescore.home_league_entry.team.short_name)
                            .font(.caption)
                            .padding(.leading)
                        Spacer()
                        if let homeScore = gamescore.home_runs {
                            Text(String(homeScore))
                                .font(.title3)
                                .bold()
                                .frame(maxWidth: 40, alignment: .center)
                                .foregroundColor(gamescore.home_team_name.contains("Skylarks") ? Color.accentColor : Color.primary)
                        }
                    }
                }
            }
            .onAppear(perform: {
                setLogos()
            })
        #endif
    }
}

struct ScoresOverView_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            ScoresOverView(gamescore: dummyGameScores[7])
                .preferredColorScheme(.dark)
        }
        //.background(Color.backgroundGrayPreview)
        .cornerRadius(8)
    }
}
