//
//  ScoresDateBar.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 13.10.22.
//

import SwiftUI

struct ScoresDateBar: View {
    var gamescore: GameScore
    
    var body: some View {
        if let gameDate = gamescore.gameDate {
            HStack {
                Text(gameDate, format: Date.FormatStyle().weekday())
                Text(gameDate, style: .date)
                Text(gameDate, style: .time)
            }
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(.secondary)
            .font(.subheadline)
            .allowsTightening(true)
        }
    }
}

struct ScoresDateBar_Previews: PreviewProvider {
    static var previews: some View {
        ScoresDateBar(gamescore: testGame)
    }
}
