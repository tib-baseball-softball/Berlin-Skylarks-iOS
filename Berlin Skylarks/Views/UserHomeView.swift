//
//  UserHome.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 20.10.21.
//

import SwiftUI

// this is meant to be the user's main dashboard where their favorite team is displayed

let homeViewGridSpacing: CGFloat = 30
let homeViewPadding: CGFloat = 25

struct UserHomeView: View {
    
    //or ObservedObject
    @StateObject var userSettings = UserSettings()
    
    // 110 is good for iPhone SE, spacing lower than 38 makes elements overlap on iPad landscape orientation
    
    let smallColumns = [
        GridItem(.adaptive(minimum: 110), spacing: 38),
    ]
    let bigColumns = [
        GridItem(.adaptive(minimum: 300), spacing: 30),
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: smallColumns, spacing: 30) {
                    Image("Rondell")
                        .resizable()
                        .scaledToFit()
                    
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
                        Text("Landesliga Baseball")
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
                            Text("9")
                                .bold()
                                .padding(10)
                            Text(":")
                            Text("1")
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
                        Text(".900")
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
                            //this will obviously be replaced with the real variable
                            let dummyRank = "1."
                            if dummyRank == "1." {
                                Image(systemName: "crown")
                                    .font(.title)
                                    .foregroundColor(Color.accentColor)
                            } else {
                                Image(systemName: "hexagon")
                                    .font(.title)
                                    .foregroundColor(Color.accentColor)
                            }
                            Text(dummyRank)
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
                        StandingsTableView(leagueTable: dummyLeagueTable)
                            .frame(height: 485)
                            .cornerRadius(NewsItemCornerRadius)
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
