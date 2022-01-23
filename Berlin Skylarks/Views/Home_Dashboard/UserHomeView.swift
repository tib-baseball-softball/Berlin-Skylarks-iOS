//
//  UserHomeView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 20.10.21.
//

import SwiftUI

// this is meant to be the user's main dashboard where their favorite team is displayed

struct UserHomeView: View {
    
    @AppStorage("favoriteTeam") var favoriteTeam: String = "Test Team"
    
    @State private var showingSheetSettings = false
    @State private var showingSheetNextGame = false
    @State private var showingSheetLastGame = false
    
    @State var showNextGame = true
    @State var showLastGame = true
    
    @StateObject var userDashboard = UserDashboard()
    @State private var homeGamescores = [GameScore]()
    @State var homeLeagueTables = [LeagueTable]()
    @State var displayTeam = testTeam
    
    @State var selectedHomeTablesURL = URL(string: "nonsense")!
    @State var selectedHomeScoresURL = URL(string: "nonsense")!
    
    func setFavoriteTeam() {
        for team in allSkylarksTeams where favoriteTeam == team.name {
            displayTeam = team
            selectedHomeTablesURL = displayTeam.leagueTableURL
            selectedHomeScoresURL = displayTeam.scoresURL
        }
    }
    
    func loadHomeTeamTable() {
        
        loadTableData(url: selectedHomeTablesURL) { loadedTable in
            userDashboard.leagueTable = loadedTable
            
            homeLeagueTables.append(loadedTable)
            
            //we have loaded the table for the favorite team, now we have to identify the row of said team to display this information prominently at the top
            
            for row in userDashboard.leagueTable.rows where row.team_name.contains("Skylarks") {
                
                //we have two teams for BZL, so the function needs to account for the correct one
                if displayTeam == team3 {
                    if row.team_name == "Skylarks 3" {
                        userDashboard.tableRow = row
                    }
                } else if displayTeam == team4 {
                    if row.team_name == "Skylarks 4" {
                        userDashboard.tableRow = row
                    }
                } else if displayTeam != team3 && displayTeam != team4 {
                    userDashboard.tableRow = row
                }
            }
        }
    }
    
    func loadHomeGameData() {
        
        //get the games, then process for next and last
    
        loadGameScoreData(url: selectedHomeScoresURL) { loadedData in
            homeGamescores = loadedData
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
        }
    }
    
    // 110 is good for iPhone SE, spacing lower than 38 makes elements overlap on iPad landscape orientation. Still looks terrible on some Mac sizes...
    
    let smallColumns = [
        GridItem(.adaptive(minimum: 110), spacing: 38),
    ]
    let bigColumns = [
        GridItem(.adaptive(minimum: 300), spacing: 30, alignment: .topLeading),
    ]
    
    var body: some View {
        
        #if !os(watchOS)
        ScrollView {
            
            //-------------------------------------------//
            // Small grid with team info (from table data)
            //-------------------------------------------//
            
            LazyVGrid(columns: smallColumns, spacing: 30) {
                Image("Rondell")
                    .resizable()
                    .scaledToFit()
                    .accessibilityLabel("Berlin Skylarks Logo")
//                        .overlay(
//                            Circle()
//                                .stroke(lineWidth: 2.0)
//                        )
                
                VStack(alignment: .center, spacing: NewsItemSpacing) {
                    HStack {
                        Image(systemName: "star.fill")
                            .font(.title)
                        Text("Favorite Team")
                            .font(.title2)
                            .bold()
                    }
                    .padding(5)
                    Divider()
                        .frame(width: 100)
                    Text(displayTeam.name)
                        .font(.system(size: 18))
                        .padding(5)
                }
                .frame(minWidth: 150, minHeight: 150)
                .background(ItemBackgroundColor)
                .cornerRadius(NewsItemCornerRadius)
                
                VStack(alignment: .center, spacing: NewsItemSpacing) {
                    HStack {
                        Image(systemName: "tablecells")
                            .font(.title)
                        Text("League")
                            .font(.title2)
                            .bold()
                    }
                    .padding(5)
                    Divider()
                        .frame(width: 100)
                    Text(userDashboard.leagueTable.league_name)
                        .font(.system(size: 18))
                        .padding(5)
                }
                .frame(minWidth: 150, minHeight: 150)
                .background(ItemBackgroundColor)
                .cornerRadius(NewsItemCornerRadius)
                
                VStack(alignment: .center, spacing: NewsItemSpacing) {
                    HStack {
                        Image(systemName: "sum")
                            .font(.title)
                        Text("Record")
                            .font(.title2)
                            .bold()
                    }
                    .padding(5)
                    Divider()
                        .frame(width: 100)
                    HStack {
                        Text(String(userDashboard.tableRow.wins_count))
                            .bold()
                            .padding(.vertical, 10)
                        Text("-")
                        Text(String(userDashboard.tableRow.losses_count))
                            .bold()
                            .padding(.vertical, 10)
                    }
                    .font(.largeTitle)
                }
                .frame(minWidth: 150, minHeight: 150)
                .background(ItemBackgroundColor)
                .cornerRadius(NewsItemCornerRadius)
                
                VStack(alignment: .center, spacing: NewsItemSpacing) {
                    HStack {
                        Image(systemName: "percent")
                            .font(.title)
                        Text("Wins")
                            .font(.title2)
                            .bold()
                    }
                    .padding(5)
                    Divider()
                        .frame(width: 100)
                    Text(userDashboard.tableRow.quota)
                        .bold()
                        .padding(10)
                        .font(.largeTitle)
                }
                .frame(minWidth: 150, minHeight: 150)
                .background(ItemBackgroundColor)
                .cornerRadius(NewsItemCornerRadius)
                
                VStack(alignment: .center, spacing: NewsItemSpacing) {
                    HStack {
                        Image(systemName: "number")
                            .font(.title)
                        Text("Rank")
                            .font(.title2)
                            .bold()
                    }
                    .padding(5)
                    Divider()
                        .frame(width: 100)
                    HStack {
                        if userDashboard.tableRow.rank == "1." {
                            Image(systemName: "crown")
                                .font(.title)
                                .foregroundColor(Color.accentColor)
                        }
//                            else {
//                                Image(systemName: "hexagon")
//                                    .font(.title)
//                                    .foregroundColor(Color.accentColor)
//                            }
                        Text(userDashboard.tableRow.rank)
                            .bold()
                            .padding(10)
                            .font(.largeTitle)
                    }
                }
                .frame(minWidth: 150, minHeight: 150)
                .background(ItemBackgroundColor)
                .cornerRadius(NewsItemCornerRadius)
            }
            .padding(25)
            
            //-------------------------------------------//
            //GRID with last game, next game and table
            //-------------------------------------------//
          
            LazyVGrid(columns: bigColumns, spacing: 30) {
                
                if showLastGame == true {
                    VStack(alignment: .leading) {
                        Text("Latest Score")
                            .font(.title)
                            .bold()
                            .padding(.leading, 15)
                        
                            ScoresOverView(gamescore: userDashboard.LastGame)
                            
                            .onTapGesture {
                                showingSheetLastGame.toggle()
                            }
                            .sheet(isPresented: $showingSheetLastGame) {
                                ScoresDetailView(gamescore: userDashboard.LastGame)
                            }
                    }
                } else {
                    VStack(alignment: .leading) {
                        Text("Latest Score")
                            .font(.title)
                            .bold()
                            .padding(.leading, 15)
                        Text("There is no recent game to display.")
                            .padding()
                            .background(ScoresSubItemBackground)
                            .cornerRadius(NewsItemCornerRadius)
                    }
                }
                
                if showNextGame == true {
                    VStack(alignment: .leading) {
                        Text("Next Game")
                            .font(.title)
                            .bold()
                            .padding(.leading, 15)
                            ScoresOverView(gamescore: userDashboard.NextGame)
                            
                            .onTapGesture {
                                showingSheetNextGame.toggle()
                            }
                            .sheet(isPresented: $showingSheetNextGame) {
                                ScoresDetailView(gamescore: userDashboard.NextGame)
                            }
                    }
                } else {
                    VStack(alignment: .leading) {
                        Text("Next Game")
                            .font(.title)
                            .bold()
                            .padding(.leading, 15)
                        Text("There is no next game to display.")
                            .padding()
                            .background(ScoresSubItemBackground)
                            .cornerRadius(NewsItemCornerRadius)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Standings")
                        .font(.title)
                        .bold()
                        .padding(.leading, 15)
                    if homeLeagueTables != [] {
                        StandingsTableView(leagueTable: homeLeagueTables[0])
                            .frame(height: 485)
                        .cornerRadius(NewsItemCornerRadius)
                    } else {
                        Text("No standings available")
                    }
                }
            }
            .padding(homeViewPadding)
            
            VStack(alignment: .leading) {
                Text("Team News")
                    .font(.title)
                    .bold()
                    .padding(.leading, 15)
                ScrollView(.horizontal) {
                    LazyHStack {
                        NewsItem()
                        NewsItem()
                        NewsItem()
                        NewsItem()
                        NewsItem()
                    }
                }
                .frame(height: 450)
            }
            .padding(homeViewPadding)
        }
        .navigationTitle("Dashboard")
        
        .onAppear(perform: {
            setFavoriteTeam()
            loadHomeTeamTable()
            loadHomeGameData()
        })
        
        .onChange(of: favoriteTeam, perform: { favoriteTeam in
            setFavoriteTeam()
            homeLeagueTables = []
            loadHomeTeamTable()
            loadHomeGameData()
        })
        
    //we are showing the app settings here, but only on iPhone, since the 5 tab items are full. On iPad/Mac the sidebar has more than enough space to include settings
    
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                if UIDevice.current.userInterfaceIdiom == .phone {
                    Button(
                        action: {
                            showingSheetSettings.toggle()
                        }
                    ){
                        Image(systemName: "gearshape.fill")
                    }
                    .padding(.horizontal, 5)
                    .sheet( isPresented: $showingSheetSettings) {
                        NavigationView {
                            SettingsListView()
                        }
                    }
                }
            }
        }
        #else
        List {
            Section(header: Text("Favorite Team")) {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.skylarksRed)
                        Text(userDashboard.tableRow.team_name)
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
                    Divider()
                        .padding(.vertical)
                    Group {
                        HStack {
                            Image(systemName: "sum")
                                .frame(maxWidth: 20)
                            Text(String(userDashboard.tableRow.wins_count) + "-" + String(userDashboard.tableRow.losses_count))
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
                .padding()
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
                if homeLeagueTables != [] {
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
        .navigationTitle("Dashboard")
        
        .onAppear(perform: {
            setFavoriteTeam()
            loadHomeTeamTable()
            loadHomeGameData()
        })
        
        .onChange(of: favoriteTeam, perform: { favoriteTeam in
            setFavoriteTeam()
            homeLeagueTables = []
            loadHomeTeamTable()
            loadHomeGameData()
        })
        
        #endif
    }
}

struct UserHomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            UserHomeView()
                .preferredColorScheme(.dark)
        }
    }
}
