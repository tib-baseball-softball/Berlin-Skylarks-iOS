//
//  PlayoffSeriesView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 13.10.22.
//

import SwiftUI

struct PlayoffSeriesView: View {
    var playoffSeries: PlayoffSeries
    var playoffGames: [GameScore]
    
    var body: some View {
        NavigationStack {
            List {
                Section(
                    header: Text("Status"),
                    footer: Text("Series Length: ") + Text("Best of \(playoffSeries.seriesLength)")) {
                        HStack {
                            Spacer()
                            VStack {
                                switch playoffSeries.status {
                                    case .tied:
                                        Text("Series tied")
                                        Text("\(playoffSeries.firstTeam.wins) - \(playoffSeries.secondTeam.wins)")
                                            .font(.largeTitle)
                                            .bold()
                                            .padding(1)
                                    case .leading:
                                        Text("\(playoffSeries.leadingTeam.name) lead series")
                                        Text("\(playoffSeries.leadingTeam.wins) - \(playoffSeries.trailingTeam.wins)")
                                            .font(.largeTitle)
                                            .bold()
                                            .padding(1)
                                    case .won:
                                        Text("\(playoffSeries.leadingTeam.name) win series")
                                        Text("\(playoffSeries.leadingTeam.wins) - \(playoffSeries.trailingTeam.wins)")
                                            .font(.largeTitle)
                                            .bold()
                                            .padding(1)
                                }
                            }
                            .padding(2)
                            Spacer()
                        }
                    }
                Section(header: Text("Games")) {
                    ForEach(playoffGames) { gamescore in
                        NavigationLink(destination: ScoresDetailView(gamescore: gamescore)) {
                            PlayoffScoreOverView(gamescore: gamescore)
                        }
                    }
                }
                .listRowSeparatorTint(.skylarksRed)
            }
            .frame(maxWidth: 600)
            .navigationTitle("Playoffs")
        }
    }
}
