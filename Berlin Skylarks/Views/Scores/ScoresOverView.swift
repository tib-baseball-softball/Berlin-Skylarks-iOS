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
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(gamescore.league.name)
                        .font(.headline.smallCaps())
                    if let gameDate = gamescore.gameDate {
                        HStack {
                            Text(gameDate, format: Date.FormatStyle().weekday())
                            Text(gameDate, style: .date)
                            Text(gameDate, style: .time)
                        }
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                    }
                    Divider()
                        .frame(maxWidth: 200)
                        .padding(.vertical, 3)
                }
                Spacer()
                GameResultIndicator(gamescore: gamescore)
                    .font(.headline)
            }
            HStack {
                roadLogo
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 40, alignment: .center)
                Text(gamescore.away_team_name)
                    .padding(.leading)
                Spacer()
                if let awayScore = gamescore.away_runs, let homeScore = gamescore.home_runs {
                    Text(String(awayScore))
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: 40, alignment: .center)
                        .foregroundColor(awayScore < homeScore ? Color.secondary : Color.primary)
                }
            }
            HStack {
                homeLogo
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 40, alignment: .center)
                Text(gamescore.home_team_name)
                    .padding(.leading)
                Spacer()
                if let awayScore = gamescore.away_runs, let homeScore = gamescore.home_runs {
                    Text(String(homeScore))
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: 40, alignment: .center)
                        .foregroundColor(awayScore > homeScore ? Color.secondary : Color.primary)
                }
            }
        }
        .padding(.vertical, 2)
        .onAppear {
            setLogos()
        }
#endif
        
        //---------------------------------------------------------//
        //-----------start Apple Watch-specific code---------------//
        //---------------------------------------------------------//
        
#if os(watchOS)
        VStack {
            VStack {
                Text(gamescore.league.name)
                    .font(.caption2)
                if let gameDate = gamescore.gameDate {
                    HStack {
                        Text(gameDate, format: Date.FormatStyle().weekday())
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
                    if let awayScore = gamescore.away_runs, let homeScore = gamescore.home_runs {
                        Text(String(awayScore))
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: 40, alignment: .center)
                            .foregroundColor(awayScore < homeScore ? Color.secondary : Color.primary)
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
                    if let awayScore = gamescore.away_runs, let homeScore = gamescore.home_runs {
                        Text(String(homeScore))
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: 40, alignment: .center)
                            .foregroundColor(awayScore > homeScore ? Color.secondary : Color.primary)
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
        List {
            ScoresOverView(gamescore: dummyGameScores[3])
            ScoresOverView(gamescore: dummyGameScores[47])
            ScoresOverView(gamescore: dummyGameScores[25])
            Section {
                ScoresOverView(gamescore: dummyGameScores[8])
            }
            Section {
                ScoresOverView(gamescore: dummyGameScores[57])
            }
        }
        //.preferredColorScheme(.dark)
    }
}
