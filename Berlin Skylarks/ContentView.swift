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
    
    /*@Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>*/

    //this creates the tab bar at the bottom
    
    
    var body: some View {
        TabView {
            NewsView()
                .tabItem {
                    Image(systemName: "newspaper.fill")
                    Text("News")
                }
            Text("SCORES")
                .tabItem {
                    Image(systemName: "42.square.fill")
                    Text("Scores")
                }
            Text("STANDINGS") //these are placeholders to put the real views into
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Standings")
                }
            TeamListView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Players")
                }
            Text("ABOUT")
                .tabItem {
                    Image(systemName: "info.circle.fill")
                    Text("Info")
                }
        }
    }
}

//preview settings

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().preferredColorScheme(.dark).padding(0.0).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
        
    }
}
