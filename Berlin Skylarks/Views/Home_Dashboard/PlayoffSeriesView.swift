//
//  PlayoffSeriesView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 13.10.22.
//

import SwiftUI

struct PlayoffSeriesView: View {
    
    @ObservedObject var userDashboard: UserDashboard
    
    var body: some View {
        
        //TODO: needs some polish for iPad
        NavigationStack {
            List {
                Section(
                    header: Text("Status"),
                    footer: Text("Series Length: Best of \(userDashboard.playoffSeries.seriesLength)"
                                )) {
                                    HStack {
                                        Spacer()
                                        VStack {
                                            switch userDashboard.playoffSeries.status {
                                            case .tied:
                                                Text("Series tied")
                                                Text("\(userDashboard.playoffSeries.firstTeam.wins) - \(userDashboard.playoffSeries.secondTeam.wins)")
                                                    .font(.largeTitle)
                                                    .bold()
                                                    .padding(1)
                                            case .leading:
                                                Text("\(userDashboard.playoffSeries.leadingTeam.name) lead series")
                                                Text("\(userDashboard.playoffSeries.leadingTeam.wins) - \(userDashboard.playoffSeries.trailingTeam.wins)")
                                                    .font(.largeTitle)
                                                    .bold()
                                                    .padding(1)
                                            case .won:
                                                Text("\(userDashboard.playoffSeries.leadingTeam.name) win series")
                                                Text("\(userDashboard.playoffSeries.leadingTeam.wins) - \(userDashboard.playoffSeries.trailingTeam.wins)")
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
                    ForEach(userDashboard.playoffGames) { gamescore in
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
}

struct PlayoffSeriesView_Previews: PreviewProvider {
    static var previews: some View {
        PlayoffSeriesView(userDashboard: UserDashboard())
    }
}
