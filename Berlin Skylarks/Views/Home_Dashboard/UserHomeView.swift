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
    @StateObject var userSettings = UserSettings()
    
    @AppStorage("favoriteTeam") var favoriteTeam: String = "Test Team"
    
    @State private var showingSettings = false
    
    @StateObject var userDashboard = UserDashboard()
    
    @State var homeLeagueTables = [LeagueTable]()
    
    @State var selectedHomeURL = urlVLBB //just a default value that is immediately overridden
    
    func setCorrectURL() {
        for (name, url) in dashboardTeamURLDict {
            if favoriteTeam == name {
                selectedHomeURL = url
            }
        }
    }
    
    func loadHomeTableData(url: URL) {
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in

            if let data = data {
                if let response_obj = try? JSONDecoder().decode(LeagueTable.self, from: data) {

                    DispatchQueue.main.async {
                        userDashboard.displayDashboardLeagueTable = response_obj
                        
                        homeLeagueTables.append(response_obj)
                        
                        for row in userDashboard.displayDashboardLeagueTable.rows {
                            if row.team_name.contains("Skylarks") {
                                userDashboard.displayDashboardTableRow = row
                            }
                        }
                    }
                }
            }
        }.resume()
    }
    
    // 110 is good for iPhone SE, spacing lower than 38 makes elements overlap on iPad landscape orientation. Still looks terrible on some Mac sizes...
    
    let smallColumns = [
        GridItem(.adaptive(minimum: 110), spacing: 38),
    ]
    let bigColumns = [
        GridItem(.adaptive(minimum: 300), spacing: 30),
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                //Text(homeLeagueTables.debugDescription)
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
                        Text(favoriteTeam)
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
                        Text(userDashboard.displayDashboardLeagueTable.league_name)
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
                            Text(String(userDashboard.displayDashboardTableRow.wins_count))
                                .bold()
                                .padding(10)
                            Text(":")
                            Text(String(userDashboard.displayDashboardTableRow.losses_count))
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
                        Text(userDashboard.displayDashboardTableRow.quota)
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
                            if userDashboard.displayDashboardTableRow.rank == "1." {
                                Image(systemName: "crown")
                                    .font(.title)
                                    .foregroundColor(Color.accentColor)
                            } else {
                                Image(systemName: "hexagon")
                                    .font(.title)
                                    .foregroundColor(Color.accentColor)
                            }
                            Text(userDashboard.displayDashboardTableRow.rank)
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
                    VStack(alignment: .leading) {
                        Text("Latest Score")
                            .font(.title)
                            .bold()
                            .padding(.leading, 15)
                        ScoresOverView(gamescore: dummyGameScores[7])
                    }
                    VStack(alignment: .leading) {
                        Text("Next Game")
                            .font(.title)
                            .bold()
                            .padding(.leading, 15)
                        ScoresOverView(gamescore: dummyGameScores[0])
                    }
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
                setCorrectURL()
                loadHomeTableData(url: selectedHomeURL)
            })
            
            .onChange(of: favoriteTeam, perform: { favoriteTeam in
                setCorrectURL()
                homeLeagueTables = []
                loadHomeTableData(url: selectedHomeURL)
            })
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(
                        action: {
                            showingSettings.toggle()
                        }
                    ){
                        Image(systemName: "gearshape.fill")
                    }
                    .padding(.horizontal, 5)
                    .sheet( isPresented: $showingSettings) {
                        SettingsListView()
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct UserHomeView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            UserHomeView().preferredColorScheme($0)
        }
    }
}
