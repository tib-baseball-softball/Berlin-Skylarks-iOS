//
//  TeamDetailView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 25.12.20.
//

import SwiftUI

struct TeamDetailView: View {
    @State private var vm: TeamDetailViewModel = TeamDetailViewModel()
    @State private var playerListDisplayMode: PlayerListDisplayMode = .image
    @State private var showingTrainingSheet = false

    var team: Components.Schemas.Team
    let listRowPadding: CGFloat = 3

    private func load() async {
        await vm.loadPlayers(id: nil, bsmID: nil, team: team.uid)
        do {
            try await vm.loadTrainingsForTeam(id: team.uid)
        } catch {
            print(error)
        }
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

            Section(header: Text("Practice Times")) {
                switch vm.trainingState {
                case .notInitialised:
                    Text("unitialised")
                case .loading:
                    LoadingView()
                case .found:
                    Button("Show Practices") {
                        showingTrainingSheet = true
                    }
                    .sheet(isPresented: $showingTrainingSheet) {
                        TrainingSheet(trainings: vm.trainings)
                            .presentationDetents([.fraction(0.75), .large])
                            .frame(height: 500)
                    }

                case .noResults:
                    ContentUnavailableView(
                        "No Trainings found.", systemImage: "dumbbell")
                case .error:
                    ContentUnavailableView(
                        "An error occured while loading data.",
                        systemImage: "exclamationmark.square")
                }
            }

            Section(header: Text("Player Profiles")) {
                Picker("Display mode", selection: $playerListDisplayMode) {
                    Text("Image").tag(PlayerListDisplayMode.image)
                    Text("Number").tag(PlayerListDisplayMode.number)
                }
                .pickerStyle(.segmented)

                switch vm.playerState {
                case .notInitialised:
                    Text("unitialised")
                case .loading:
                    LoadingView()
                case .found:
                    ForEach(vm.players, id: \.uid) { player in
                        NavigationLink(
                            destination: PlayerDetailView(player: player)
                        ) {
                            PlayerListRow(
                                player: player,
                                displayMode: playerListDisplayMode)
                        }
                    }
                case .noResults:
                    ContentUnavailableView(
                        "No Players found.", systemImage: "person.3.fill")
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
            vm.trainings = []
            await load()
        }

        .onAppear {
            if vm.players == [] || vm.trainings == [] {
                Task {
                    await load()
                }
            }
        }
    }
}

#Preview {
    TeamDetailView(
        team: .init(
            uid: 3, name: "Team 2", bsmLeague: 5647, leagueId: 6,
            bsmShortName: "BEA2")
    )
}
