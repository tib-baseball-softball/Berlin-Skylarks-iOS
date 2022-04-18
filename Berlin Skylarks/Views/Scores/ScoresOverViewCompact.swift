//
//  ScoresOverViewCompact.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 18.04.22.
//

import SwiftUI

struct ScoresOverViewCompact: View {
    
    var gamescore: GameScore
    
    @State var roadLogo = away_team_logo
    @State var homeLogo = home_team_logo
    
    func setLogos() {
        let logos = fetchCorrectLogos(gamescore: gamescore)
        roadLogo = logos.road
        homeLogo = logos.home
    }
    
    var body: some View {
        VStack {
            VStack {
                Text(gamescore.league.name)
                    .font(.headline)
                if let gameDate = gamescore.gameDate {
                    HStack {
                        Text(gameDate, style: .date)
                        Text(gameDate, style: .time)
                    }
                    .foregroundColor(.secondary)
                    .font(.subheadline)
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
        }
        .padding(.vertical, 2)
        .onAppear(perform: {
            setLogos()
        })
    }
}

struct ScoresOverViewCompact_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ScoresOverViewCompact(gamescore: dummyGameScores[3])
            ScoresOverViewCompact(gamescore: dummyGameScores[47])
            ScoresOverViewCompact(gamescore: dummyGameScores[25])
            ScoresOverViewCompact(gamescore: dummyGameScores[8])
            ScoresOverViewCompact(gamescore: dummyGameScores[57])
        }
        //.preferredColorScheme(.dark)
        .listStyle(.insetGrouped)
    }
}
