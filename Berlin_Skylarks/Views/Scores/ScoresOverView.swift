//
//  ScoresOverView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 27.12.20.
//

import SwiftUI

struct ScoresOverView: View {

    var gamescore: GameScore

    var body: some View {

        //logos now set here instead of .onAppear
        let logos = TeamImageData.fetchCorrectLogos(gamescore: gamescore)

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
            ScoresTeamBar(
                teamLogo: logos.road, gamescore: gamescore, home: false)
            ScoresTeamBar(
                teamLogo: logos.home, gamescore: gamescore, home: true)
        }
        .padding(.vertical, 2)
    }
}

#Preview {
    List {
        Section {
            //ScoresOverView(gamescore: dummyGameScores[3])
        }
    }
}
