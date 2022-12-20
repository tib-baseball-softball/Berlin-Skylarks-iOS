//
//  PlayoffScoreOverView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 13.10.22.
//

import SwiftUI

struct PlayoffScoreOverView: View {
    
    var gamescore: GameScore
    
    var body: some View {
        VStack {
            let logos = fetchCorrectLogos(gamescore: gamescore)
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    let gameNumber = String(gamescore.match_id.suffix(1))
                    Text("\(gamescore.league.acronym) Playoff Game \(gameNumber)")
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.headline.smallCaps())
                        .allowsTightening(true)
                    ScoresDateBar(gamescore: gamescore)
                    Divider()
                        .background(Color.skylarksSand)
                        //.frame(maxWidth: 200)
                        .padding(.vertical, 3)
                }
                Spacer()
                GameResultIndicator(gamescore: gamescore)
                    .font(.headline)
            }
            ScoresTeamBar(teamLogo: logos.road, gamescore: gamescore, home: false)
            ScoresTeamBar(teamLogo: logos.home, gamescore: gamescore, home: true)
        }
    }
}

struct PlayoffScoreOverView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Section {
                PlayoffScoreOverView(gamescore: dummyGameScores[0])
                PlayoffScoreOverView(gamescore: dummyGameScores[1])
                PlayoffScoreOverView(gamescore: dummyGameScores[1])
                PlayoffScoreOverView(gamescore: testGame)
            }
            .listRowSeparatorTint(.skylarksRed)
        }
    }
}
