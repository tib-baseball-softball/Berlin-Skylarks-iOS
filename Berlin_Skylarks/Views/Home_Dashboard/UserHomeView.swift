//
//  UserHomeView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 20.10.21.
//

import SwiftUI

/// this is the user's main dashboard where their favorite team is displayed
struct UserHomeView: View {
    @AppStorage("favoriteTeam") var favoriteTeam: String = "Not set"
    @AppStorage("favoriteTeamID") var favoriteTeamID = 0
    @AppStorage("selectedSeason") var selectedSeason = Calendar(
        identifier: .gregorian
    ).dateComponents([.year], from: .now).year ?? 2025
    @AppStorage("didLaunchBefore") var didLaunchBefore = false
    
    @Environment(NetworkManager.self) var networkManager: NetworkManager
    @State private var showAlertNoNetwork = false
    @State var vm = HomeViewModel()
    
    @State private var showingSheetSettings = false
    @State private var showingSheetNextGame = false
    @State private var showingSheetLastGame = false
    @State var showingSheetTeams = false
    
    @State private var loadingScores = false
    @State private var loadingTables = false
    
    @State var teams = [BSMTeam]()
    @State var leagueGroups = [LeagueGroup]()
    @State var displayTeam: BSMTeam = emptyTeam
    
    //should be overridden before first network call - but isn't
    @State var selectedHomeTablesURL = URL(
        string: "https://www.tib-baseball.de")!
    @State var selectedHomeScoresURL = URL(
        string: "https://www.tib-baseball.de")!
    
    //-------------------------------------------//
    //LOCAL FUNCTIONS
    //-------------------------------------------//
    
    func loadProcessHomeData() async {
        if networkManager.isConnected == false {
            showAlertNoNetwork = true
        }
        
        displayTeam = await setFavoriteTeam()
        loadingTables = true
        loadingScores = true
        leagueGroups = await loadLeagueGroups(season: selectedSeason)
        await vm.loadHomeData(
            team: displayTeam, leagueGroups: leagueGroups,
            season: selectedSeason)
        loadingScores = false
        loadingTables = false
    }
    
    func setFavoriteTeam() async -> BSMTeam {
        do {
            teams = try await loadSkylarksTeams(season: selectedSeason)
        } catch {
            print("Request failed with error: \(error)")
        }
        
        for team in teams where team.id == favoriteTeamID {
            displayTeam = team
        }
        return displayTeam
    }
    
    var body: some View {
        List {
            if favoriteTeamID == AppSettings.NO_TEAM_ID {
                Section(header: Text("Favorite Team")) {
                    Text(
                        "You haven't selected a favorite Team yet. Select one via the button in the toolbar to have its latest standings and scores appear here."
                    )
                }
            } else {
                favoriteTeamSection
                leagueGroupsSection
                
                if vm.homeDatasets.isEmpty && loadingTables == false && loadingScores == false {
                    Text("No data available.")
                }
                
                if loadingTables == true || loadingScores == true {
                    LoadingView()
                }
            }
        }
        .navigationTitle("Dashboard")
        .onAppear(perform: {
            if vm.homeDatasets.isEmpty {
                Task {
                    await loadProcessHomeData()
                }
            }
        })
        .refreshable {
            await loadProcessHomeData()
        }
        .onChange(of: favoriteTeamID) {
            Task {
                displayTeam = await setFavoriteTeam()
            }
            vm.homeDatasets = []
        }
        .onChange(of: didLaunchBefore) {
            Task {
                await loadProcessHomeData()
            }
        }
        .sheet(
            isPresented: $showingSheetTeams,
            onDismiss: {
                Task {
                    await loadProcessHomeData()
                }
            },
            content: {
                SelectTeamSheet()
                    .presentationDetents([.fraction(0.8)])
            }
        )
        .alert("No network connection", isPresented: $showAlertNoNetwork) {
            Button("OK") {}
        } message: {
            Text(
                "No active network connection has been detected. The app needs a connection to download its data."
            )
        }
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button(action: {
                    showingSheetTeams = true
                }) {
                    Image(systemName: "person.3")
                        .foregroundColor(.skylarksRed)
                }
            }
        }
    }

    private var favoriteTeamSection: some View {
        Section(header: Text("Favorite Team")) {
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.skylarksRed)
                Text(
                    "\(displayTeam.name) (\(displayTeam.league_entries.first?.league.acronym ?? ""))"
                )
                .padding(.leading)
            }
            HStack {
                Image(systemName: "tablecells")
                    .frame(maxWidth: 20)
                    .foregroundColor(Color.skylarksAdaptiveBlue)
                Text(displayTeam.league_entries.first?.league.name ?? "")
                    .padding(.leading)
            }
            HStack {
                Image(systemName: "calendar.badge.clock")
                    .frame(maxWidth: 20)
                    .foregroundColor(Color.skylarksAdaptiveBlue)
                Text(String(displayTeam.league_entries.first?.league.season ?? selectedSeason))
                    .padding(.leading)
            }
        }
    }

    private var leagueGroupsSection: some View {
        ForEach(vm.homeDatasets, id: \.id) { dataset in
            TableSummarySection(loadingTables: loadingTables, team: displayTeam, dataset: dataset)
                .environment(vm)
            if dataset.playoffParticipation {
                Section(header: Text("Playoffs")) {
                    HStack {
                        Image(systemName: "trophy.fill")
                            .foregroundColor(.skylarksRed)
                        NavigationLink(
                            destination: PlayoffSeriesView(
                                playoffSeries: dataset.playoffSeries, playoffGames: dataset.playoffGames)
                        ) {
                            Text("See playoff series")
                        }
                    }
                }
            }
            Section(header: Text("Next Game")) {
                if dataset.showNextGame == true && !loadingScores {
                    NavigationLink(
                        destination: ScoresDetailView(
                            gamescore: dataset.nextGame)
                    ) {
                        ScoresOverView(gamescore: dataset.nextGame)
                    }
                } else if !dataset.showNextGame && !loadingScores {
                    Text("There is no next game to display.")
                }
                if loadingScores == true {
                    LoadingView()
                }
            }
            Section(header: Text("Latest Score")) {
                if dataset.showLastGame == true && !loadingScores {
                    NavigationLink(
                        destination: ScoresDetailView(
                            gamescore: dataset.lastGame)
                    ) {
                        ScoresOverView(gamescore: dataset.lastGame)
                    }
                } else if !dataset.showLastGame && !loadingScores {
                    Text("There is no recent game to display.")
                }
            }
        }
    }
}

#Preview {
    UserHomeView()
}
