//
//  GamedayTeamBlock.swift
//  WidgetSkylarksExtension
//
//  Created by David Battefeld on 04.07.22.
//

import SwiftUI
import WidgetKit

struct GamedayTeamBlock: View {
    
    var gamescore: GameScore
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(gamescore.league.acronym)
                    .font(.caption)
                    //.foregroundColor(.skylarksDynamicNavySand)
                Divider()
                    .offset(x: 0, y: -3)
                HStack {
                    //TODO: change
                    Image("Bird_whiteoutline")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 15)
                    Text(gamescore.away_league_entry.team.short_name)
                    Spacer()
                    if let awayScore = gamescore.away_runs, let homeScore = gamescore.home_runs {
                        ScoreNumber(displayScore: awayScore, otherScore: homeScore)
                            .font(.caption.bold())
                            
                    }
                }
                HStack {
                    //TODO: change
                    Image("Sluggers_Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 15)
                    Text(gamescore.home_league_entry.team.short_name)
                    Spacer()
                    if let awayScore = gamescore.away_runs, let homeScore = gamescore.home_runs {
                        ScoreNumber(displayScore: homeScore, otherScore: awayScore)
                            .font(.caption.bold())
                    }
                }
            }
        }
        .font(.caption)
        .padding(4)
        //.foregroundColor(.white)
        .background(ContainerRelativeShape().fill(Color(UIColor.secondarySystemBackground)))
        .overlay(RoundedRectangle(cornerRadius: 5)
            .stroke(Color.skylarksSand)
        )
    }
}

struct GamedayTeamBlock_Previews: PreviewProvider {
    static var previews: some View {
        GamedayTeamBlock(gamescore: dummyGameScores[0])
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
