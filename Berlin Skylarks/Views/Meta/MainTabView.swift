//
//  MainTabView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 16.06.22.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationView {
                UserHomeView()
            }
            //TODO: check appearance for iPhone Pro Max
            .navigationViewStyle(.automatic)
                .tabItem {
                    Image(systemName: "star.square.fill")
                    Text("Home")
                }
            //since News is non-functional right now, let's rather have the settings back in the tab bar
//                NavigationView {
//                    NewsView()
//                }
//                    .tabItem {
//                        Image(systemName: "newspaper.fill")
//                        Text("News")
//                    }
            NavigationView {
                ScoresView()
            }
                .tabItem {
                    Image(systemName: "42.square.fill")
                    Text("Scores")
                }
            NavigationView {
                StandingsView()
            }
                .tabItem {
                    Image(systemName: "tablecells.fill")
                    Text("Standings")
                }
            NavigationView {
                TeamListView()
            }
                .tabItem {
                    Image(systemName: "shield.fill")
                    Text("Club")
                }
            NavigationView {
                SettingsListView()
            }
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
