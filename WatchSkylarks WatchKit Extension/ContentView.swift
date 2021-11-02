//
//  ContentView.swift
//  WatchSkylarks WatchKit Extension
//
//  Created by David Battefeld on 02.11.21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Image(systemName: "star")
                        .foregroundColor(Color.accentColor)
                    Text("Favorite Team")
                }
                HStack {
                    Image(systemName: "newspaper")
                        .foregroundColor(Color.accentColor)
                    Text("News")
                }
                HStack {
                    Image(systemName: "42.square")
                        .foregroundColor(Color.accentColor)
                    Text("Scores")
                }
                HStack {
                    Image(systemName: "tablecells")
                        .foregroundColor(Color.accentColor)
                    Text("Standings")
                }
                HStack {
                    Image(systemName: "person.3")
                        .foregroundColor(Color.accentColor)
                    Text("Players")
                }
                HStack {
                    Image(systemName: "gearshape")
                        .foregroundColor(Color.accentColor)
                    Text("Settings")
                }
            }            
            .navigationTitle("Home")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
