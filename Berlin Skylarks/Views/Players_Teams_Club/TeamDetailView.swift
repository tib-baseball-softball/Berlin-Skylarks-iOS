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
                NavigationLink(destination: Text("Player List here")) {
                    HStack {
                        Image(systemName: "person.3.sequence.fill")
                        Text("Show Player List")
                    }
                    .padding(.vertical)
                }

                if vm.loadingInProgress == true {
                    LoadingView()
                }

                ForEach(vm.players, id: \.uid) { player in
                    NavigationLink(destination: Text("Player Detail")) {
                        HStack {
                            Image(systemName: "person.3.fill")
                            Text(player.fullname)
                        }
                    }
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
            uid: 2, name: "Team 2", bsmLeague: 5647, leagueId: 6,
            bsmShortName: "BEA2")
    )
    .preferredColorScheme(.dark)
}
