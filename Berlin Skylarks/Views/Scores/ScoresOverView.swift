//
//  ScoresOverView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 27.12.20.
//

import SwiftUI

struct ScoresOverView: View {
    
    //this is called a "stored property"
    var gamescore: GameScore
    
    var body: some View {
        setCorrectLogo(gamescore: gamescore)
        getDatefromBSMString(gamescore: gamescore)
        determineGameStatus(gamescore: gamescore)
        return
            VStack(spacing: ScoresItemSpacing) {
                VStack {
                    Text(gamescore.league.name)
                        .font(.title2)
                        .bold()
                    Divider()
                        .frame(width: 180)
                    HStack {
                        Image(systemName: "calendar")
                        Text(gameDate!, style: .date)
                        Divider()
                            .frame(height: 30)
                        Image(systemName: "clock.fill")
                        Text(gameDate!, style: .time)
                    }.padding(ScoresItemPadding)
                    Divider()
                        .frame(width: 180)
                    if gamescore.human_state.contains("geplant") {
                        Text("TBD")
                            .font(.title)
                            .bold()
                    }
                    if gamescore.human_state.contains("ausgefallen") {
                        Text("PPD")
                            .font(.title)
                            .bold()
                    }
                    if gamescore.human_state.contains("gespielt") {
                        if !isDerby {
                            if skylarksWin {
                                Text("W")
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(Color.green)
                            } else {
                                Text("L")
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(Color.accentColor)
                            }
                        } else {
                            VStack {
                                Image(systemName: "heart.fill")
                                    .font(.title)
                                    .foregroundColor(Color.accentColor)
                                Text("Derby - Skylarks win either way")
                                    .padding(ScoresItemPadding)
                            }
                        }
                    }
                }
                HStack {
                    VStack {
                        Text("Guest")
                            .font(.title3)
                            .bold()
                        away_team_logo?
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50, alignment: .center)
                        Text(gamescore.away_team_name)
                            .frame(width: teamNameFrame)
                            .lineLimit(nil)
                    }
                    Spacer()
                    if let awayScore = gamescore.away_runs {
                        Text(String(awayScore))
                            .font(.largeTitle)
                            .bold()
                            .padding(ScoresNumberPadding)
                            .foregroundColor(gamescore.away_team_name.contains("Skylarks") ? Color.accentColor : Color.primary)
                    }
                    
                }
                .padding(ScoresItemPadding)
                .background(ScoresSubItemBackground)
                .cornerRadius(NewsItemCornerRadius)
                HStack {
                    VStack {
                        Text("Home")
                            .font(.title3)
                            .bold()
                        home_team_logo?
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50, alignment: .center)
                        Text(gamescore.home_team_name)
                            .frame(width: teamNameFrame)
                            .lineLimit(nil)
                    }
                    Spacer()
                    
                    if let homeScore = gamescore.home_runs {
                        Text(String(homeScore))
                            .font(.largeTitle)
                            .bold()
                            .padding(ScoresNumberPadding)
                            .foregroundColor(gamescore.home_team_name.contains("Skylarks") ? Color.accentColor : Color.primary)
                    }
                }
                .padding(ScoresItemPadding)
                .background(ScoresSubItemBackground)
                .cornerRadius(NewsItemCornerRadius)
        }
        .padding(ScoresItemPadding)
        .background(.regularMaterial) //switch on or off depending on whether I use List or Grid
        .cornerRadius(NewsItemCornerRadius)
    }
}

struct ScoresOverView_Previews: PreviewProvider {
    
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ScoresOverView(gamescore: dummyGameScores[7]).preferredColorScheme($0)
        }
    }
}
