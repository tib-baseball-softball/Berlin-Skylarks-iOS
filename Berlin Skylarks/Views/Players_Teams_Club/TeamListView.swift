//
//  TeamListView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 25.12.20.
//

import SwiftUI

struct TeamListView: View {
    @State private var vm: SkylarksTeamViewModel = SkylarksTeamViewModel()
    @AppStorage("favoriteTeamID") var favoriteTeamID = 0

    @Environment(NetworkManager.self) var networkManager: NetworkManager
    @State private var showAlertNoNetwork = false
    
    private func load() async {
        vm.loadingInProgress = true
        await vm.loadClubTeams(id: nil)
        vm.loadingInProgress = false
    }

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Team data")) {
                    HStack {
                        Image(systemName: "person.3.fill")
                            .padding(.trailing)
                        #if !os(watchOS)
                            Text("Team")
                        #endif
                        Spacer()
                        Text("Acronym")
                            .frame(maxWidth: 110, alignment: .leading)
                            .padding(.trailing)
                    }
                    .font(.headline)
                    .listRowBackground(ColorStandingsTableHeadline)

                    if vm.loadingInProgress == true {
                        LoadingView()
                    }

                    ForEach(vm.teams, id: \.self) { team in
                        NavigationLink(
                            destination: TeamDetailView(team: team)
                        ) {
                            HStack {
                                Image(systemName: "person.3")
                                    .foregroundColor(
                                        .skylarksDynamicNavySand
                                    )
                                    .padding(.trailing)
                                HStack {
                                    Text(team.name)
                                    if team.bsmLeague == favoriteTeamID {
                                        Image(systemName: "star")
                                            .foregroundColor(
                                                .skylarksRed)
                                    }
                                }
                                Spacer()
                                Text(team.bsmShortName)
                                    .frame(
                                        maxWidth: 110,
                                        alignment: .leading
                                    )
                                    .allowsTightening(true)
                            }
                        }
                    }

                    if vm.teams.isEmpty && vm.loadingInProgress == false {
                        Text("No team data.")
                    }
                }
            }
            .navigationTitle("Skylarks Club Teams")
            .frame(maxWidth: 600)

            .refreshable {
                vm.teams = []
                await load()
            }

            .onAppear(perform: {
                if vm.teams == [] {
                    Task {
                       await load()
                    }
                }
            })

            .alert(
                "No network connection", isPresented: $showAlertNoNetwork
            ) {
                Button("OK") {}
            } message: {
                Text(
                    "No active network connection has been detected. The app needs a connection to download its data."
                )
            }
        }
    }
}

#Preview {
    TeamListView()
        .environment(NetworkManager())
        .preferredColorScheme(.dark)
}
