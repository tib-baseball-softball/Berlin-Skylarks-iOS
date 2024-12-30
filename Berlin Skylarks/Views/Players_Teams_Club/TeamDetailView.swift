//
//  TeamDetailView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 25.12.20.
//

import SwiftUI

struct TeamDetailView: View {
    @State private var vm: PlayerViewModel = PlayerViewModel()
    @State private var playerListDisplayMode: PlayerListDisplayMode = .image

    var team: Components.Schemas.Team
    let listRowPadding: CGFloat = 3

    private func load() async {
        await vm.loadPlayers(id: nil, bsmID: nil, team: team.uid)
    }

    var body: some View {
        List {
            Section(header: Text("Team data")) {
                HStack {
                    Image(systemName: "person.3.fill")
                    Text(team.name)
                }
                .padding(.vertical, listRowPadding)
                HStack {
                    Image(systemName: "note.text")
                    Text(team.bsmShortName)
                }
                .padding(.vertical, listRowPadding)
            }
            Section(header: Text("Player profiles")) {
                Picker("Display mode", selection: $playerListDisplayMode) {
                    Text("Image").tag(PlayerListDisplayMode.image)
                    Text("Number").tag(PlayerListDisplayMode.number)
                }
                #if !os(watchOS)
                    .pickerStyle(.segmented)
                #endif

                switch vm.viewState {
                case .notInitialised:
                    Text("unitialised")
                case .loading:
                    LoadingView()
                case .found:
                    ForEach(vm.players, id: \.uid) { player in
                        NavigationLink(destination: PlayerDetailView(player: player)) {
                            PlayerListRow(
                                player: player,
                                displayMode: playerListDisplayMode)
                        }
                    }
                case .noResults:
                    ContentUnavailableView(
                        "No Players found", systemImage: "person.3.fill")
                case .error:
                    ContentUnavailableView(
                        "An error occured while loading data.",
                        systemImage: "exclamationmark.square")
                }
            }
        }
        .navigationTitle(team.name)
        #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
        #endif
        .frame(maxWidth: 600)

        .refreshable {
            vm.players = []
            await load()
        }

        .onAppear(perform: {
            if vm.players == [] {
                Task {
                    await load()
                }
            }
        })
    }
}

#Preview {
    TeamDetailView(
        team: .init(
            uid: 3, name: "Team 2", bsmLeague: 5647, leagueId: 6,
            bsmShortName: "BEA2")
    )
}
