//
//  UserHomeView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 20.10.21.
//

import SwiftUI

// this is meant to be the user's main dashboard where their favorite team is displayed

struct UserHomeView: View {
    
    //StateObject / ObservedObject
    //@StateObject var userSettings = UserSettings()
    
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
    
    func loadHomeTeamTable(url: URL) {
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in

            if let data = data {
                if let response_obj = try? JSONDecoder().decode(LeagueTable.self, from: data) {

                    DispatchQueue.main.async {
                        userDashboard.leagueTable = response_obj
                        
                        homeLeagueTables.append(response_obj)
                        
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
            }
        }.resume()
    }
    
    func loadHomeGameData(url: URL) {
        
        //get the games
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                if let response_obj = try? JSONDecoder().decode([GameScore].self, from: data) {
                    
                    DispatchQueue.main.async {
                        self.homeGamescores = response_obj
                        processGameDates()
                    }
                }
            }
        }.resume()
    }
    
    func processGameDates() {
        // processing
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        
        //for testing purposes this is set to some date in the season, normally it's just the current date
        //let now = Date()
        let now = formatter.date(from: "20210928") ?? Date.now // September 27th, 2021 UTC
        
        //var allGames = [GameScore]()
        var nextGames = [GameScore]()
        var previousGames = [GameScore]()

        for (index, _) in homeGamescores.enumerated() {
            homeGamescores[index].gameDate = getDatefromBSMString(gamescore: homeGamescores[index])
            //print(homeGamescores)
        }
        for gamescore in homeGamescores where gamescore.gameDate! > now {
            nextGames.append(gamescore)
        }
        if nextGames != [] {
            showNextGame = true
            userDashboard.NextGame = nextGames.first!
        } else {
            showNextGame = false
        }
        
        //Add last games to separate array and set it to be displayed
        for gamescore in homeGamescores where gamescore.gameDate! < now {
            previousGames.append(gamescore)
        }
        if previousGames != [] {
            showLastGame = true
            userDashboard.LastGame = previousGames.last!
        } else {
            showLastGame = false
        }
    }
    
    // 110 is good for iPhone SE, spacing lower than 38 makes elements overlap on iPad landscape orientation. Still looks terrible on some Mac sizes...
    
    let smallColumns = [
        GridItem(.adaptive(minimum: 110), spacing: 38),
    ]
    let bigColumns = [
        GridItem(.adaptive(minimum: 300), spacing: 30),
    ]
    
    var body: some View {
        //NavigationView {
            ScrollView {
                //Text(homeGamescores.debugDescription)
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
                                .padding(10)
                            Text(":")
                            Text(String(userDashboard.tableRow.losses_count))
                                .bold()
                                .padding(10)
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
                            } else {
                                Image(systemName: "hexagon")
                                    .font(.title)
                                    .foregroundColor(Color.accentColor)
                            }
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
                
                //GRID with last game, next game and table
              
                LazyVGrid(columns: bigColumns, spacing: 30) {
                    
                    //if showingLastGame == true {
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
//                    } else {
//                        Text("There is no recent game to display.")
//                    }
                    
                    //if showingNextGame == true {
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
//                    } else {
//                        Text("There is no next game to display.")
//                    }
                    
                    VStack(alignment: .leading) {
                        Text("Standings")
                            .font(.title)
                            .bold()
                            .padding(.leading, 15)
                        if homeLeagueTables.indices.contains(0) {
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
                loadHomeTeamTable(url: selectedHomeTablesURL)
                loadHomeGameData(url: selectedHomeScoresURL)
            })
            
            .onChange(of: favoriteTeam, perform: { favoriteTeam in
                setFavoriteTeam()
                homeLeagueTables = []
                loadHomeTeamTable(url: selectedHomeTablesURL)
                loadHomeGameData(url: selectedHomeScoresURL)
            })
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
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
        //}
        //.navigationViewStyle(.stack)
    }
}

struct UserHomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(ColorScheme.allCases, id: \.self) {
                UserHomeView().preferredColorScheme($0)
            }
        }
    }
}
