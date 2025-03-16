//
//  GameResultIndicator.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 06.06.22.
//

import SwiftUI

struct GameResultIndicator: View {
    
    var gamescore: GameScore
    
    var body: some View {
        if gamescore.human_state.contains("geplant") {
            Text("TBD")
                .bold()
                .padding()
        }
        if gamescore.human_state.contains("ausgefallen") {
            Text("PPD")
                .bold()
                .padding()
        }
        if let derby = gamescore.isDerby, let win = gamescore.skylarksWin, let external = gamescore.isExternalGame {
            if gamescore.human_state.contains("gespielt") ||
                gamescore.human_state.contains("Forfeit") ||
                gamescore.human_state.contains("Nichtantreten") ||
                gamescore.human_state.contains("Wertung") ||
                gamescore.human_state.contains("Rückzug") ||
                gamescore.human_state.contains("Ausschluss") {
                if !derby {
                    if win && !external {
                        Text("W")
                            .bold()
                            .foregroundColor(.green)
                            .padding()
                    } else if !win && !external {
                        Text("L")
                            .bold()
                            .foregroundColor(.accentColor)
                            .padding()
                    } else if external {
                        Text("F")
                            .bold()
                            .padding()
                    }
                } else {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.skylarksRed)
                        .padding()
                }
            }
        }
    }
}

struct GameResultIndicator_Previews: PreviewProvider {
    static var previews: some View {
        GameResultIndicator(gamescore: testGame)
    }
}
