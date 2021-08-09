//
//  ContentView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 23.12.20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    //this stuff was in here from the start, no idea if it's important
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    //this creates the tab bar at the bottom
    
    
    var body: some View {
        TabView {
            NewsView()
                .tabItem {
                    Image(systemName: "newspaper.fill")
                    Text("News")
                }
            ScoresView()
                .tabItem {
                    Image(systemName: "42.square.fill")
                    Text("Scores")
                }
            StandingsView()
                .tabItem {
                    Image(systemName: "tablecells.fill")
                    Text("Standings")
                }
            TeamListView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Players")
                }
            SettingsListView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
    }
}

//preview settings

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().padding(0.0).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
        
    }
}
