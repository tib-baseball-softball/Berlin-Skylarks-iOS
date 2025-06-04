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
    ).dateComponents([.year], from: .now).year!
    @AppStorage("didLaunchBefore") var didLaunchBefore = false

    @Environment(NetworkManager.self) var networkManager: NetworkManager
    @State private var showAlertNoNetwork = false

    @State private var showingSheetSettings = false
    @State private var showingSheetNextGame = false
    @State private var showingSheetLastGame = false
    @State var showingSheetTeams = false

    @State var showingTableData = false

    @State private var loadingScores = false
    @State private var loadingTables = false

    @StateObject var vm = HomeViewModel()
    @State var homeLeagueTables = [LeagueTable]()
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
        await loadHomeTeamTable(team: displayTeam, leagueGroups: leagueGroups)
        loadingTables = false
        await vm.loadHomeGameData(
            team: displayTeam, leagueGroups: leagueGroups,
            season: selectedSeason)
        loadingScores = false
    }

    func setFavoriteTeam() async -> BSMTeam {
        //get all teams
        do {
            teams = try await loadSkylarksTeams(season: selectedSeason)
        } catch {
            print("Request failed with error: \(error)")
        }

        //check for the favorite one
        for team in teams where team.id == favoriteTeamID {
            displayTeam = team
        }
        return displayTeam
    }

    func loadHomeTeamTable(team: BSMTeam, leagueGroups: [LeagueGroup]) async {

        //load table for specific leagueGroup that corresponds to favorite team
        let tables = await loadTablesForTeam(team: team, leagueGroups: leagueGroups)
        
        for table in tables {
            let row = determineTableRow(team: team, table: table)

            homeLeagueTables.append(table)
            vm.leagueTable = table
            vm.tableRow = row
        }

        if !homeLeagueTables.isEmpty {
            showingTableData = true
        }
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
                        Text(vm.leagueTable.league_name)
                            .padding(.leading)
                    }
                    HStack {
                        Image(systemName: "calendar.badge.clock")
                            .frame(maxWidth: 20)
                            .foregroundColor(Color.skylarksAdaptiveBlue)
                        Text(String(vm.leagueTable.season))
                            .padding(.leading)
                    }
                }
                
                ForEach(homeLeagueTables, id: \.league_id) { table in
                    TableSummarySection(showingTableData: showingTableData, loadingTables: loadingTables, team: displayTeam, table: table)
                        .environmentObject(vm)
                }
                
                if homeLeagueTables.isEmpty {
                    Text("No Standings available.")
                }
                
                if vm.playoffParticipation {
                    Section(header: Text("Playoffs")) {
                        HStack {
                            Image(systemName: "trophy.fill")
                                .foregroundColor(.skylarksRed)
                            NavigationLink(
                                destination: PlayoffSeriesView(
                                    vm: vm)
                            ) {
                                Text("See playoff series")
                            }
                        }
                    }
                }
                
                Section(header: Text("Next Game")) {
                    if vm.showNextGame == true && !loadingScores {
                        NavigationLink(
                            destination: ScoresDetailView(
                                gamescore: vm.NextGame)
                        ) {
                            ScoresOverView(gamescore: vm.NextGame)
                        }
                    } else if !vm.showNextGame && !loadingScores {
                        Text("There is no next game to display.")
                    }
                    if loadingScores == true {
                        LoadingView()
                    }
                }
                Section(header: Text("Latest Score")) {
                    if vm.showLastGame == true && !loadingScores {
                        NavigationLink(
                            destination: ScoresDetailView(
                                gamescore: vm.LastGame)
                        ) {
                            ScoresOverView(gamescore: vm.LastGame)
                        }
                    } else if !vm.showLastGame && !loadingScores {
                        Text("There is no recent game to display.")
                    }
                    if loadingScores == true {
                        LoadingView()
                    }
                }
            }
        }
        .navigationTitle("Dashboard")

        .animation(.default, value: vm.tableRow)
        .animation(.default, value: vm.NextGame)
        .animation(.default, value: vm.LastGame)
        .animation(.default, value: vm.playoffParticipation)

        .onAppear(perform: {
            if homeLeagueTables.isEmpty {
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
            homeLeagueTables = []
            vm.homeGamescores = []
        }

        //this triggers only after the first launch once the onboarding sheet is dismissed. This var starts false, is set to true after the user selects their favorite team and is never set back to false anywhere
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
        .navigationTitle("Dashboard")
    }
}

#Preview {
    UserHomeView()
}
