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
            //UserDefaults.standard.setCodableObject(favoriteTeam, forKey: "favoriteTeam")
        }
    }
    
    @Published var sendPush: Bool {
        didSet {
            UserDefaults.standard.set(sendPush, forKey: "sendPush")
        }
    }
    
    public var skylarksTeams = ["Team 1", "Softball", "Team 2", "Team 3", "Team 4", "Jugend", "Schüler", "Tossball", "Teeball" ]
    
    init() {
        self.favoriteTeam = UserDefaults.standard.object(forKey: "favoriteTeam") as? String ?? "Team 1"
        self.sendPush = UserDefaults.standard.object(forKey: "sendPush") as? Bool ?? false
    }
}

struct SettingsListView: View {
    
    @ObservedObject var userSettings = UserSettings()
    //@State private var showingTestView = false
    
    @AppStorage("season") var seasonYear = Calendar(identifier: .gregorian).dateComponents([.year], from: .now).year!
    
    var body: some View {
        List {
            //MARK: commented out for beta testing (not functional yet)
//            Section(
//                    header: Text("Notifications"),
//                    footer: Text("Receive notifications for all Skylarks teams or just your favorite team.")) {
//                Toggle(isOn: $userSettings.sendPush) {
//                        Text("Send Push Notifications")
//                }
//                .toggleStyle(SwitchToggleStyle(tint: Color("AccentColor")))
//
//                NavigationLink(
//                    destination: InfoView()) {
//                    HStack {
//                        Image(systemName: "bell.badge.fill")
//                            .font(.title3)
//                        Text("Notify on")
//                    }
//                }
//                NavigationLink(
//                    destination: InfoView()) {
//                    HStack {
//                        Image(systemName: "person.2.fill")
//                            .font(.title3)
//                        Text("Frequency")
//                    }
//                }
//            }
            Section(
                header: Text("Time Range"),
                footer: Text("The selected season is applied globally in the app.")
            ) {
                Picker(selection: $seasonYear, label:
                    HStack {
                        Image(systemName: "deskclock.fill")
                            .font(.title3)
                        Text("Season")
                }) {
                    ForEach(2017...Calendar(identifier: .gregorian).dateComponents([.year], from: .now).year!, id: \.self) { season in
                        Text(String(season))
                    }
                }
            }
            Section(
                header: Text("Teams"),
                footer: Text("Your favorite team appears in the Home dashboard tab.")) {
                    Picker(selection: $userSettings.favoriteTeam, label:
                        HStack {
                            Image(systemName: "star.square.fill")
                                .font(.title3)
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
                            .font(.title3)
                        Text("App Info")
                    }
                }
//                HStack {
//                    Text("©")
//                        .font(.title)
//                    Text("Acknowledgements")
//                }
                HStack {
                    Text("§")
                        .font(.title)
                    Text("Imprint")
                }
            }
        }
    #if !os(watchOS)
        .listStyle(.insetGrouped)
    #endif
    
//            .toolbar {
//                ToolbarItem(placement: .automatic) {
//                    Button(
//                        action: {
//                            showingTestView.toggle()
//                        }
//                    ){
//                        Image(systemName: "info.circle.fill")
//                    }
//                    .padding(.horizontal, 5)
//                    .sheet( isPresented: $showingTestView) {
//                        TestView()
//                    }
//                }
//            }
        
        .navigationTitle("Settings")
        .onChange(of: seasonYear, perform: { value in
            currentSeason = String(value)
        })
    }
}

struct SettingsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsListView()
        }
    }
}
