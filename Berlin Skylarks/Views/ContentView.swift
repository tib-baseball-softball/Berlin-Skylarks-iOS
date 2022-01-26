//
//  ContentView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 23.12.20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>

    //main navigation view
    
    
    var body: some View {
        
        //iPhone/iPad/Mac
        
        #if !os(watchOS)
        //the interface on iPhone uses a tab bar at the bottom
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            TabView {
                NavigationView {
                    UserHomeView()
                }
                .navigationViewStyle(.stack)
                    .tabItem {
                        Image(systemName: "star.square.fill")
                        Text("Home")
                    }
                
                NavigationView {
                    NewsView()
                }
                    .tabItem {
                        Image(systemName: "newspaper.fill")
                        Text("News")
                    }
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
                        Image(systemName: "person.3.fill")
                        Text("Teams")
                    }
//                SettingsListView()
//                    .tabItem {
//                        Image(systemName: "gearshape.fill")
//                        Text("Settings")
//                    }
            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Image(systemName: "plus")
//                }
//            }
        }
        //on iPad and macOS we use a sidebar navigation to make better use of the ample space
        
        if UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.userInterfaceIdiom == .mac {
            SidebarNavigationView()
        }
        #endif
        
        //Apple Watch
        #if os(watchOS)
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
        #endif
    }
}

//preview settings

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
//                .padding(0.0).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
                //.previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
