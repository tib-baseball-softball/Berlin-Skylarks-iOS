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
            NavigationStack {
                UserHomeView()
            }
                .tabItem {
                    Image(systemName: "star.square.fill")
                    Text("HomeTab", comment: "refers to the home tab in the tab view")
                }
            //since News is non-functional right now, let's rather have the settings back in the tab bar
//                NavigationView {
//                    NewsView()
//                }
//                    .tabItem {
//                        Image(systemName: "newspaper.fill")
//                        Text("News")
//                    }
            NavigationStack {
                ScoresView()
            }
                .tabItem {
                    Image(systemName: "42.square.fill")
                    Text("Scores", comment: "tab view")
                }
            NavigationStack {
                StandingsView()
            }
                .tabItem {
                    Image(systemName: "tablecells.fill")
                    Text("Standings", comment: "tab view")
                }
            NavigationStack {
                ClubView()
            }
                .tabItem {
                    Image(systemName: "shield.fill")
                    Text("Club", comment: "tab view")
                }
            NavigationStack {
                SettingsListView()
            }
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings", comment: "tab view")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(NetworkManager())
    }
}
