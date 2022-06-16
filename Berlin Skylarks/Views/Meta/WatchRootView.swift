//
//  WatchRootView.swift
//  WatchSkylarks WatchKit Extension
//
//  Created by David Battefeld on 16.06.22.
//

import SwiftUI

struct WatchRootView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(
                    destination: UserHomeView()){
                        HStack {
                            Image(systemName: "star")
                                .foregroundColor(Color.accentColor)
                            Text("Favorite Team")
                        }
                    }
                //                HStack {
                //                    Image(systemName: "newspaper")
                //                        .foregroundColor(Color.accentColor)
                //                    Text("News")
                //                }
                NavigationLink(
                    destination: ScoresView()) {
                        HStack {
                            Image(systemName: "42.square")
                                .foregroundColor(Color.accentColor)
                            Text("Scores")
                        }
                    }
                NavigationLink(
                    destination: StandingsView()) {
                        HStack {
                            Image(systemName: "tablecells")
                                .foregroundColor(Color.accentColor)
                            Text("Standings")
                        }
                    }
                
                //                HStack {
                //                    Image(systemName: "person.3")
                //                        .foregroundColor(Color.accentColor)
                //                    Text("Players")
                //                }
                NavigationLink(
                    destination: SettingsListView()) {
                        HStack {
                            Image(systemName: "gearshape")
                                .foregroundColor(Color.accentColor)
                            Text("Settings")
                        }
                    }
                
            }
            .navigationTitle("Home")
        }
    }
}

struct WatchRootView_Previews: PreviewProvider {
    static var previews: some View {
        WatchRootView()
    }
}
