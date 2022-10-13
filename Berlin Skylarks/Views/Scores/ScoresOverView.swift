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
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.headline.smallCaps())
                        .allowsTightening(true)
                    ScoresDateBar(gamescore: gamescore)
                    Divider()
                        .frame(maxWidth: 200)
                        .padding(.vertical, 3)
                }
                Spacer()
                GameResultIndicator(gamescore: gamescore)
                    .font(.headline)
            }
            ScoresTeamBar(teamLogo: roadLogo, gamescore: gamescore, home: false)
            ScoresTeamBar(teamLogo: homeLogo, gamescore: gamescore, home: true)
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
            Section {
                ScoresOverView(gamescore: dummyGameScores[3])
                ScoresOverView(gamescore: dummyGameScores[0])
                ScoresOverView(gamescore: GameScore(id: 45, match_id: "43464", time: "none", league_id: 5464, home_runs: 5, away_runs: 12, home_team_name: "Skylarks", away_team_name: "Away Team", human_state: "gespielt", league: League(id: 56, season: 2022, name: "Jugendaufbauliga Baseball fsdhdfjdfjdf sdhdfj ukdfkudf", acronym: "JugABB", sport: "Baseball", classification: "Kreisliga"), home_league_entry: homeEntry, away_league_entry: awayEntry, umpire_assignments: [], scorer_assignments: []))
            }
            Section {
                ScoresOverView(gamescore: dummyGameScores[1])
            }
            Section {
                ScoresOverView(gamescore: dummyGameScores[0])
            }
        }
        //.preferredColorScheme(.dark)
    }
}
