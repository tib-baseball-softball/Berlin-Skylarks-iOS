//
//  UserHomeView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 20.10.21.
//

import SwiftUI

/// The main dashboard view displaying the user's favorite team, standings, and scores.
///
/// This view manages the user's favorite team selection, displays relevant data,
/// and provides navigation to detailed views such as standings, scores, and playoff series.
struct UserHomeView: View {
    /// The user's selected favorite team name.
    @AppStorage("favoriteTeam") var favoriteTeam: String = "Not set"
    /// The user's selected favorite team ID.
    @AppStorage("favoriteTeamID") var favoriteTeamID = 0
    /// The selected season for displaying data.
    @AppStorage("selectedSeason") var selectedSeason = Calendar(
        identifier: .gregorian
    ).dateComponents([.year], from: .now).year ?? 2025
    /// Indicates whether the app has been launched before.
    @AppStorage("didLaunchBefore") var didLaunchBefore = false
    
    /// The network manager environment object.
    @Environment(NetworkManager.self) var networkManager: NetworkManager
    /// Controls the display of the no network alert.
    @State private var showAlertNoNetwork = false
    /// The view model for the home dashboard.
    @State var vm = HomeViewModel()
    
    @State private var showingSheetSettings = false
    @State private var showingSheetNextGame = false
    @State private var showingSheetLastGame = false
    /// Controls the display of the team selection sheet.
    @State var showingSheetTeams = false
    
    /// Indicates if scores are currently loading.
    @State private var loadingScores = false
    /// Indicates if tables are currently loading.
    @State private var loadingTables = false
    
    /// The list of teams available to the user.
    @State var teams = [BSMTeam]()
    /// The list of league groups for the selected season.
    @State var leagueGroups = [LeagueGroup]()
    /// The team currently displayed as the favorite.
    @State var displayTeam: BSMTeam = emptyTeam
    
    /// The URL for the selected home tables.
    @State var selectedHomeTablesURL = URL(
        string: "https://www.tib-baseball.de")!
    /// The URL for the selected home scores.
    @State var selectedHomeScoresURL = URL(
        string: "https://www.tib-baseball.de")!
    
    //-------------------------------------------//
    //LOCAL FUNCTIONS
    //-------------------------------------------//
    
    /// Loads and processes the home dashboard data, including teams, league groups, and home datasets.
    ///
    /// This method checks for network connectivity, loads the user's favorite team,
    /// retrieves league groups, and updates the view model with the latest data.
    func loadProcessHomeData() async {
        if networkManager.isConnected == false {
            showAlertNoNetwork = true
        }
        print("favorite Team ID is \(favoriteTeamID)")
        
        vm.homeDatasets = []
        
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
    
    /// Sets the user's favorite team based on the stored favorite team ID.
    ///
    /// - Returns: The `BSMTeam` object corresponding to the favorite team ID, or `emptyTeam` if not found.
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
            if vm.homeDatasets.isEmpty || displayTeam == emptyTeam {
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
                await loadProcessHomeData()
            }
        }
        
        .onChange(of: didLaunchBefore) {
            Task {
                await loadProcessHomeData()
            }
        }
        
        .onChange(of: selectedSeason) {
            print("selected season changed, invalidating home data...")
            vm.homeDatasets = []
        }
        
        .sheet(
            isPresented: $showingSheetTeams,
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
    
    /// Section displaying the user's favorite team and its league information.
    private var favoriteTeamSection: some View {
        Section(
            header: Text("Favorite Team"),
            footer: Text("A single team can be associated with several leagues in BSM in the same season.")
        ) {
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
    
    /// Section displaying league group summaries, playoff participation, and upcoming/latest games.
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
        .environment(NetworkManager())
}
