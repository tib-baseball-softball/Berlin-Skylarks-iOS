//
//  PlayoffSeriesView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 13.10.22.
//

import SwiftUI

struct PlayoffSeriesView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var vm: HomeViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                #if !os(macOS)
                Color(colorScheme == .light ? .secondarySystemBackground : .systemBackground)
                    .edgesIgnoringSafeArea(.all)
                #endif
                List {
                    Section(
                        header: Text("Status"),
                        footer: Text("Series Length: ") + Text("Best of \(vm.playoffSeries.seriesLength)")) {
                            HStack {
                                Spacer()
                                VStack {
                                    switch vm.playoffSeries.status {
                                    case .tied:
                                        Text("Series tied")
                                        Text("\(vm.playoffSeries.firstTeam.wins) - \(vm.playoffSeries.secondTeam.wins)")
                                            .font(.largeTitle)
                                            .bold()
                                            .padding(1)
                                    case .leading:
                                        Text("\(vm.playoffSeries.leadingTeam.name) lead series")
                                        Text("\(vm.playoffSeries.leadingTeam.wins) - \(vm.playoffSeries.trailingTeam.wins)")
                                            .font(.largeTitle)
                                            .bold()
                                            .padding(1)
                                    case .won:
                                        Text("\(vm.playoffSeries.leadingTeam.name) win series")
                                        Text("\(vm.playoffSeries.leadingTeam.wins) - \(vm.playoffSeries.trailingTeam.wins)")
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
                        ForEach(vm.playoffGames) { gamescore in
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
}

struct PlayoffSeriesView_Previews: PreviewProvider {
    static var previews: some View {
        PlayoffSeriesView(vm: HomeViewModel())
    }
}
