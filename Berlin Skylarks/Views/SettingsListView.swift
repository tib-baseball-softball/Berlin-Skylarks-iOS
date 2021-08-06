//
//  SettingsListView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 27.12.20.
//

import SwiftUI

struct SettingsListView: View {
    
//    this is lazily copied, needs further understanding
    @State private var sendPush = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Notifications")) {
                    Toggle(isOn: $sendPush) {
                            Text("Send Push Notifications")
                        }
                    
                    //this was a simple test of onChange syntax
                    
                    .onChange(of: sendPush, perform: { whatever in
                        print("Push enabled")
                    })
                    
                    .toggleStyle(SwitchToggleStyle(tint: Color("AccentColor")))
                    NavigationLink(
                        destination: InfoView()) {
                        HStack {
                            Image(systemName: "bell.badge.fill")
                                .font(.title)
                            Text("Notify on")
                        }
                    }
                    NavigationLink(
                        destination: InfoView()) {
                        HStack {
                            Image(systemName: "person.2.fill")
                                .font(.title)
                            Text("Frequency")
                        }
                    }
                    Text("Receive notifications for all Skylarks teams or just your favorite team.")
                        .font(.subheadline)
                        .italic()
                }
                Section(header: Text("Teams")) {
                    NavigationLink(
                        destination: InfoView()) {
                        HStack {
                            Image(systemName: "star.square.fill")
                                .font(.title)
                            Text("Favorite Team")
                        }
                    }
                    Text("Your favorite team appears at the top in Standings and Scores.")
                        .font(.subheadline)
                        .italic()
                }
                Section(header: Text("Information")) {
                    NavigationLink(
                        destination: InfoView()) {
                        HStack {
                            Image(systemName: "info.circle.fill")
                                .font(.title)
                            Text("App Info")
                        }
                    }
                    HStack {
                        Text("©")
                            .font(.largeTitle)
                        Text("Acknowledgements")
                    }
                    HStack {
                        Text("§")
                            .font(.largeTitle)
                        Text("Imprint")
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Settings")
        }
    }
}

struct SettingsListView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsListView()
    }
}
