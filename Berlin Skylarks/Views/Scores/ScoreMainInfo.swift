//
//  ScoreMainInfo.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 06.06.22.
//

import SwiftUI

struct ScoreMainInfo: View {
    
    var gamescore: GameScore
    
    var body: some View {
        HStack {
            Image(systemName: "list.bullet")
            Text(gamescore.league.name)
        }.padding(ScoresItemPadding)
        HStack {
            Image(systemName: "number")
            Text("\(gamescore.match_id)")
        }
        .padding(ScoresItemPadding)
        if let gameDate = gamescore.gameDate {
            HStack {
                Image(systemName: "calendar")
                Text(gameDate, format: Date.FormatStyle().weekday())
                Text(gameDate, style: .date)
            }
            .padding(ScoresItemPadding)
        }
        if let gameDate = gamescore.gameDate {
            HStack {
                Image(systemName: "clock.fill")
                Text(gameDate, style: .time)
            }
            .padding(ScoresItemPadding)
        }
    }
}

struct ScoreMainInfo_Previews: PreviewProvider {
    static var previews: some View {
        ScoreMainInfo(gamescore: testGame)
    }
}
