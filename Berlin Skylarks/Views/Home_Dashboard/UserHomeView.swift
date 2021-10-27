//
//  UserHomeView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 20.10.21.
//

import SwiftUI

// this is meant to be the user's main dashboard where their favorite team is displayed

var displayDashboardLeagueTable = LeagueTable(league_id: 1, league_name: "Default League", season: Calendar.current.component(.year, from: Date()), rows: [])

var displayDashboardTableRow = LeagueTable.Row(rank: "X.", team_name: "Testteam", short_team_name: "XXX", match_count: 0, wins_count: 0, losses_count: 0, quota: ".000", games_behind: "0", streak: "00")

let dashboardTeamURLDict = [
    "Team 1 (VL)" : urlVLBB,
    "Softball (VL)" : urlVLSB,
    "Team 2 (LL)" : urlLLBB,
    "Team 3 (BZL)" : urlBZLBB,
    "Team 4 (BZL)" : urlBZLBB,
    "Jugend (U15)": urlSchBB, //placeholder
    "Schüler (U12)" : urlSchBB,
    "Tossball (U10)" : urlTossBB,
    "Teeball (U8)" : urlSchBB, //placeholder
]

let homeViewGridSpacing: CGFloat = 30
let homeViewPadding: CGFloat = 25

struct UserHomeView: View {
    
    //StateObject / ObservedObject
    @ObservedObject var userSettings = UserSettings()
    
    @State var homeLeagueTables = [LeagueTable]()
    
    @State var selectedHomeURL = urlVLBB //just a default value that is immediately overridden
    
    func setCorrectURL() {
        for (name, url) in dashboardTeamURLDict {
            if userSettings.favoriteTeam == name {
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
                        displayDashboardLeagueTable = response_obj
                        
                        homeLeagueTables.append(response_obj)
                        
                        for row in displayDashboardLeagueTable.rows {
                            if row.team_name.contains("Skylarks") {
                                displayDashboardTableRow = row
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
                        Text(userSettings.favoriteTeam)
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
                        Text(displayDashboardLeagueTable.league_name)
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
                            Text(String(displayDashboardTableRow.wins_count))
                                .bold()
                                .padding(10)
                            Text(":")
                            Text(String(displayDashboardTableRow.losses_count))
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
                        Text(displayDashboardTableRow.quota)
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
                            if displayDashboardTableRow.rank == "1." {
                                Image(systemName: "crown")
                                    .font(.title)
                                    .foregroundColor(Color.accentColor)
                            } else {
                                Image(systemName: "hexagon")
                                    .font(.title)
                                    .foregroundColor(Color.accentColor)
                            }
                            Text(displayDashboardTableRow.rank)
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
            
            //this does not work yet - view doesn't refresh (only after reloading app/page)
            
            .onChange(of: userSettings.favoriteTeam, perform: { favoriteTeam in
                setCorrectURL()
                loadHomeTableData(url: selectedHomeURL)
                
                //DEBUG
                print(selectedHomeURL)
                print(displayDashboardTableRow)
            })
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
