//
//  TeamDetailView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 25.12.20.
//

import SwiftUI

struct TeamDetailView: View {
    @State private var vm: PlayerViewModel = PlayerViewModel()
    var team: Components.Schemas.Team
    let listRowPadding: CGFloat = 3

    private func load() async {
        vm.loadingInProgress = true
        await vm.loadPlayers(id: nil, bsmID: nil, team: team.uid)
        vm.loadingInProgress = false
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
                switch vm.viewState {
                    case .notInitialised:
                        Text("unitialised")
                    case .loading:
                        LoadingView()
                    case .found:
                        ForEach(vm.players, id: \.uid) { player in
                            NavigationLink(destination: Text("Player Detail")) {
                                HStack {
                                    if let image = player.media?.first {
                                        AsyncImage(url: URL(string: image.url)) {
                                            loadedImage in
                                            loadedImage
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .accessibilityLabel(
                                                image.alt
                                                    ?? "Image for \(player.fullname)")
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(width: 70)
                                    } else {
                                        Image("team-placeholder")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 70)
                                            .accessibilityLabel("Placeholder image")
                                    }
                                    VStack(alignment: .leading) {
                                        Text(player.fullname)
                                        if let positions = player.positions {
                                            Text(
                                                positions.joined(
                                                    separator: ", ")
                                            ).font(.caption)
                                        }
                                    }
                                }
                            }
                        }
                    case .noResults:
                        ContentUnavailableView("No Players found", systemImage: "person.3.fill")
                    case .error:
                        ContentUnavailableView("An error occured while loading data.", systemImage: "exclamationmark.square")
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
    //.preferredColorScheme(.dark)
}
