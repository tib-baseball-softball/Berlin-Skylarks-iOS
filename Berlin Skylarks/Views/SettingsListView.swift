//
//  SettingsListView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 27.12.20.
//

import SwiftUI

class UserSettings: ObservableObject {
    @Published var favoriteTeam: String {
        didSet {
            UserDefaults.standard.set(favoriteTeam, forKey: "favoriteTeam")
        }
    }
    
    @Published var sendPush: Bool {
        didSet {
            UserDefaults.standard.set(sendPush, forKey: "sendPush")
        }
    }
    
    public var skylarksTeams = ["Team 1 (VL)", "Softball (VL)", "Team 2 (LL)", "Team 3 (BZL)", "Team 4 (BZL)", "Jugend (U15)", "Schüler (U12)", "Tossball (U10)", "Teeball (U8)" ]
    
    init() {
        self.favoriteTeam = UserDefaults.standard.object(forKey: "favoriteTeam") as? String ?? "Team 1 (VL)"
        self.sendPush = UserDefaults.standard.object(forKey: "sendPush") as? Bool ?? false
    }
}

struct SettingsListView: View {
    
    @ObservedObject var userSettings = UserSettings()
    
    var body: some View {
        //NavigationView {
            List {
                Section(
                        header: Text("Notifications"),
                        footer: Text("Receive notifications for all Skylarks teams or just your favorite team.")) {
                    Toggle(isOn: $userSettings.sendPush) {
                            Text("Send Push Notifications")
                    }
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
                }
                Section(
                    header: Text("Teams"),
                    footer: Text("Your favorite team appears in the Home dashboard tab.")) {
                    Picker(selection: $userSettings.favoriteTeam, label:
                            HStack {
                                Image(systemName: "star.square.fill")
                                    .font(.title)
                                Text("Favorite Team")
                    }) {
                        ForEach(userSettings.skylarksTeams, id: \.self) { team in
                            Text(team)
                        }
                    }
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
        #if !os(watchOS)
            .listStyle(.insetGrouped)
        #endif
            
            .navigationTitle("Settings")
        //}
        //.navigationViewStyle(.stack)
    }
}

struct SettingsListView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            SettingsListView().preferredColorScheme($0)
        }
    }
}
