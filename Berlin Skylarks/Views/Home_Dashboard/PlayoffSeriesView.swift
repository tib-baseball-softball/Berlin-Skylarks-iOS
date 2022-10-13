//
//  PlayoffSeriesView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 13.10.22.
//

import SwiftUI

struct PlayoffSeriesView: View {
    
    var gamescores: [GameScore]
    
    var body: some View {
        List {
            Section {
                ForEach(gamescores) { gamescore in
                    NavigationLink(destination: ScoresDetailView(gamescore: gamescore)) {
                        PlayoffScoreOverView(gamescore: gamescore)
                    }
                }
            }
            .listRowSeparatorTint(.skylarksRed)
        }
        .navigationTitle("Playoffs")
    }
}

struct PlayoffSeriesView_Previews: PreviewProvider {
    static var previews: some View {
        PlayoffSeriesView(gamescores: dummyGameScores)
    }
}
