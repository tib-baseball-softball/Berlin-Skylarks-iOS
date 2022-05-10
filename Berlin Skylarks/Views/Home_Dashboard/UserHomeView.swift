//
//  UserHomeView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 20.10.21.
//

import SwiftUI

// this is meant to be the user's main dashboard where their favorite team is displayed

struct UserHomeView: View {
    
    @AppStorage("favoriteTeam") var favoriteTeam: String = "Not set"
    @AppStorage("favoriteTeamID") var favoriteTeamID = 0
    @AppStorage("selectedSeason") var selectedSeason = Calendar(identifier: .gregorian).dateComponents([.year], from: .now).year!
    @AppStorage("didLaunchBefore") var didLaunchBefore = false
    
    @State private var showingSheetSettings = false
    @State private var showingSheetNextGame = false
    @State private var showingSheetLastGame = false
    
    @State var showNextGame = false
    @State var showLastGame = false
    @State var showingTableData = false
    
    let now = Date.now
    //10 days = 864000 seconds
    let lastGameDayCutoff = Date.now.addingTimeInterval(-864000)
    let nextGameDayCutoff = Date.now.addingTimeInterval(864000)
    
    @State private var loadingScores = false
    @State private var loadingTables = false
    
    @StateObject var userDashboard = UserDashboard()
    @State private var homeGamescores = [GameScore]()
    @State var homeLeagueTables = [LeagueTable]()
    @State var teams = [BSMTeam]()
    @State var leagueGroups = [LeagueGroup]()
    @State var displayTeam: BSMTeam = emptyTeam
    
    @State var selectedHomeTablesURL = URL(string: "nonsense")!
    @State var selectedHomeScoresURL = URL(string: "nonsense")!
    
    //-------------------------------------------//
    //LOCAL FUNCTIONS
    //-------------------------------------------//
    
    func loadProcessHomeData() async {
        displayTeam = await setFavoriteTeam()
        leagueGroups = await loadLeagueGroups(season: selectedSeason)
        await loadHomeTeamTable(team: displayTeam, leagueGroups: leagueGroups)
        await loadHomeGameData(team: displayTeam, leagueGroups: leagueGroups)
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
//            selectedHomeTablesURL = displayTeam.leagueTableURL
//            selectedHomeScoresURL = displayTeam.scoresURL
        }
        return displayTeam
    }
    
    func loadHomeTeamTable(team: BSMTeam, leagueGroups: [LeagueGroup]) async {
        
        loadingTables = true
        
        //load table for specific leagueGroup that corresponds to favorite team
        
        let table = await loadTableForTeam(team: team, leagueGroups: leagueGroups)
        let row = determineTableRow(team: team, table: table)
        
        homeLeagueTables.append(table)
        userDashboard.leagueTable = table
        userDashboard.tableRow = row
        
        if !homeLeagueTables.isEmpty {
            showingTableData = true
        }
        loadingTables = false
    }
    
    func loadHomeGameData(team: BSMTeam, leagueGroups: [LeagueGroup]) async {
        
        //get the games, then process for next and last
        loadingScores = true
        
        //determine the correct leagueGroup
        for leagueGroup in leagueGroups where team.league_entries[0].league.name == leagueGroup.name {
            selectedHomeScoresURL = URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=" + "\(selectedSeason)" + "&search=skylarks&filters[leagues][]=" + "\(leagueGroup.id)" + "&filters[gamedays][]=any&api_key=" + apiKey)!
        }
    
        //load data
        do {
            homeGamescores = try await fetchBSMData(url: selectedHomeScoresURL, dataType: [GameScore].self)
        } catch {
            print("Request failed with error: \(error)")
        }
        
        for (index, _) in homeGamescores.enumerated() {
            homeGamescores[index].addDates()
            homeGamescores[index].determineGameStatus()
        }
        
        //call func to check for next and last game
        let displayGames = processGameDates(gamescores: homeGamescores)
        
        if let nextGame = displayGames.next {
            userDashboard.NextGame = nextGame
            showNextGame = true
        } else {
            showNextGame = false
        }
        
        if let lastGame = displayGames.last {
            userDashboard.LastGame = lastGame
            showLastGame = true
        } else {
            showLastGame = false
        }
        loadingScores = false
    }
    
    //-------------------------------------------//
    
    // 110 is good for iPhone SE, spacing lower than 38 makes elements overlap on iPad landscape orientation. Still looks terrible on some Mac sizes...
    
    let smallColumns = [
        GridItem(.adaptive(minimum: 110), spacing: 38),
    ]
    let bigColumns = [
        GridItem(.adaptive(minimum: 300), spacing: 30, alignment: .topLeading),
    ]
    
    var body: some View {
        
#if !os(watchOS)
        List {
            Section(header: Text("Favorite Team")) {
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.skylarksRed)
                    Text("\(displayTeam.name) (\(displayTeam.league_entries[0].league.acronym))")
                        .padding(.leading)
                }
                HStack {
                    Image(systemName: "tablecells")
                        .frame(maxWidth: 20)
                        .foregroundColor(Color.skylarksAdaptiveBlue)
                    Text(userDashboard.leagueTable.league_name)
                        .padding(.leading)
                }
                HStack {
                    Image(systemName: "calendar.badge.clock")
                        .frame(maxWidth: 20)
                        .foregroundColor(Color.skylarksAdaptiveBlue)
                    Text(String(userDashboard.leagueTable.season))
                        .padding(.leading)
                }
            }
            Section(header: Text("Standings/Record")) {
                if showingTableData {
                    NavigationLink(destination: HomeTeamDetailView(userDashboard: userDashboard)) {
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "sum")
                                    .frame(maxWidth: 20)
                                    .foregroundColor(Color.skylarksAdaptiveBlue)
                                Text("\(userDashboard.tableRow.wins_count) - \(userDashboard.tableRow.losses_count)")
                                    .bold()
                                    .padding(.leading)
                            }
                            Divider()
                            HStack {
                                Image(systemName: "percent")
                                    .frame(maxWidth: 20)
                                    .foregroundColor(Color.skylarksAdaptiveBlue)
                                Text(userDashboard.tableRow.quota)
                                    .bold()
                                    .padding(.leading)
                            }
                            Divider()
                            HStack {
                                Image(systemName: "number")
                                    .frame(maxWidth: 20)
                                    .foregroundColor(Color.skylarksAdaptiveBlue)
                                Text(userDashboard.tableRow.rank)
                                    .bold()
                                    .padding(.leading)
                                if userDashboard.tableRow.rank == "1." {
                                    Image(systemName: "crown")
                                        .foregroundColor(Color.skylarksRed)
                                }
                            }
                        }
                        .padding(.vertical, 6)
                    }
                }
                if !homeLeagueTables.isEmpty {
                    NavigationLink(
                        destination: StandingsTableView(leagueTable: homeLeagueTables[0])) {
                            HStack {
                                Image(systemName: "tablecells")
                                    .foregroundColor(.skylarksRed)
                                Text("See full Standings")
                                    .padding(.leading)
                            }
                        }
                } else {
                    Text("No Standings available.")
                }
            }
            Section(header: Text("Latest Score")) {
                //this code works - but the fixed range is not very flexible
                
//                let range = lastGameDayCutoff...now
//                ForEach(homeGamescores, id: \.id) { gameScore in
//                    if let gameDate = gameScore.gameDate {
//                        if range.contains(gameDate) {
//                            NavigationLink(destination: ScoresDetailView(gamescore: gameScore)) {
//                                ScoresOverView(gamescore: gameScore)
//                            }
//                        }
//                    }
//                }
                if showLastGame == true {
                    NavigationLink(
                        destination: ScoresDetailView(gamescore: userDashboard.LastGame)) {
                            ScoresOverView(gamescore: userDashboard.LastGame)
                        }
                } else {
                    Text("There is no recent game to display.")
                }
            }
            Section(header: Text("Next Game")) {
                if showNextGame == true {
                    NavigationLink(
                        destination: ScoresDetailView(gamescore: userDashboard.NextGame)) {
                            ScoresOverView(gamescore: userDashboard.NextGame)
                        }
                } else {
                    Text("There is no next game to display.")
                }
            }
        }
        .listStyle( {
          #if os(watchOS)
            .automatic
          #else
            .insetGrouped
          #endif
        } () )
        .navigationTitle("Dashboard")
        
        .animation(.default, value: userDashboard.tableRow)
        .animation(.default, value: userDashboard.NextGame)
        .animation(.default, value: userDashboard.LastGame)
        
        .onAppear(perform: {
            Task {
                await loadProcessHomeData()
            }
        })

        .onChange(of: favoriteTeamID, perform: { favoriteTeam in
            Task {
                displayTeam = await setFavoriteTeam()
            }
            homeLeagueTables = []
            homeGamescores = []
        })
        
        //this triggers only after the first launch once the onboarding sheet is dismissed. This var starts false, is set to true after the user selects their favorite team and is never set back to false anywhere
        .onChange(of: didLaunchBefore) { firstLaunch in
            Task {
                await loadProcessHomeData()
            }
        }
//
    //we are showing the app settings here, but only on iPhone, since the 5 tab items are full. On iPad/Mac the sidebar has more than enough space to include settings
        //for now we have it back in the tab bar
    
//        .toolbar {
//            ToolbarItemGroup(placement: .navigationBarTrailing) {
//                if UIDevice.current.userInterfaceIdiom == .phone {
//                    Button(
//                        action: {
//                            showingSheetSettings.toggle()
//                        }
//                    ){
//                        Image(systemName: "gearshape.fill")
//                    }
//                    .padding(.horizontal, 5)
//                    .sheet( isPresented: $showingSheetSettings) {
//                        NavigationView {
//                            SettingsListView()
//                        }
//                    }
//                }
//            }
//        }
        
        //---------------------------------------------------------//
        //-----------start Apple Watch-specific code---------------//
        //---------------------------------------------------------//
        
#else
        List {
            Section(header: Text("Favorite Team")) {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
//                        if UIDevice.current.userInterfaceIdiom == .mac || UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.userInterfaceIdiom == .phone {
                            Image(systemName: "star.fill")
                                .foregroundColor(.skylarksRed)
                                
//                        } else {
//                            Image(systemName: "star")
//                                .foregroundColor(.skylarksRed)
//                        }

                        Text("\(displayTeam.name) (\(displayTeam.league_entries[0].league.acronym))")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.leading)
                    }
                    .padding(.top)
                    Divider()
                        .padding(.vertical)
                    HStack {
                        Image(systemName: "tablecells")
                            .frame(maxWidth: 20)
                            .foregroundColor(.skylarksSand)
                        Text(userDashboard.leagueTable.league_name)
                            .padding(.leading)
                    }
                    HStack {
                        Image(systemName: "calendar.badge.clock")
                            .frame(maxWidth: 20)
                            .foregroundColor(.skylarksSand)
                        Text(String(userDashboard.leagueTable.season))
                            .padding(.leading)
                    }
                    if showingTableData {
                        Divider()
                            .padding(.vertical)
                        Group {
                            HStack {
                                Image(systemName: "sum")
                                    .frame(maxWidth: 20)
                                Text("\(userDashboard.tableRow.wins_count) - \(userDashboard.tableRow.losses_count)")
                                    .bold()
                                    .padding(.leading)
                            }
                            HStack {
                                Image(systemName: "percent")
                                    .frame(maxWidth: 20)
                                Text(userDashboard.tableRow.quota)
                                    .bold()
                                    .padding(.leading)
                            }
                            HStack {
                                Image(systemName: "number")
                                    .frame(maxWidth: 20)
                                Text(userDashboard.tableRow.rank)
                                    .bold()
                                    .padding(.leading)
                            }
                        }
                    }
                }
                .watchOS { $0.padding() }
            }
            Section(header: Text("Latest Score")) {
                if showLastGame == true {
                    NavigationLink(
                        destination: ScoresDetailView(gamescore: userDashboard.LastGame)) {
                            ScoresOverView(gamescore: userDashboard.LastGame)
                        }
                } else {
                    Text("There is no recent game to display.")
                }
            }
            Section(header: Text("Next Game")) {
                if showNextGame == true {
                    NavigationLink(
                        destination: ScoresDetailView(gamescore: userDashboard.NextGame)) {
                            ScoresOverView(gamescore: userDashboard.NextGame)
                        }
                } else {
                    Text("There is no next game to display.")
                }
            }
            Section(header: Text("Standings")) {
                if !homeLeagueTables.isEmpty {
                    NavigationLink(
                        destination: StandingsTableView(leagueTable: homeLeagueTables[0])) {
                            HStack {
                                Image(systemName: "tablecells")
                                    .foregroundColor(.skylarksRed)
                                Text("See Standings")
                            }
                        }
                } else {
                    Text("No standings available.")
                }
            }
        }
        .listStyle( {
          #if os(watchOS)
            .automatic
          #else
            .insetGrouped
          #endif
        } () )
        .navigationTitle("Dashboard")
        
        //APPLE WATCH FUNCS //////////////////////////////////////////////////////////////
        
        .onAppear(perform: {
            Task {
                await loadProcessHomeData()
            }
        })
        
        .onChange(of: favoriteTeamID, perform: { favoriteTeam in
            Task {
                displayTeam = await setFavoriteTeam()
            }
            homeLeagueTables = []
            homeGamescores = []
        })
        
        .onChange(of: didLaunchBefore) { firstLaunch in
            Task {
                await loadProcessHomeData()
            }
        }
        
#endif
    }
}

struct UserHomeView_Previews: PreviewProvider {
    static var previews: some View {
        //Group {
            UserHomeView()
                //.preferredColorScheme(.dark)
        //}
    }
}
