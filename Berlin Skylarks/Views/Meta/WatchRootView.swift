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
                NavigationLink(destination: ClubView()) {
                    HStack {
                        Image(systemName: "shield")
                            .font(.title3)
                            .foregroundColor(.skylarksRed)
                        Text("Club")
                            .padding(.leading, -1)
                    }
                }
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
