//
//  SettingsListView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 27.12.20.
//

import SwiftUI

//class UserSettings: ObservableObject {
//    @Published var favoriteTeam: String {
//        didSet {
//            UserDefaults.standard.set(favoriteTeam, forKey: "favoriteTeam")
//            //UserDefaults.standard.setCodableObject(favoriteTeam, forKey: "favoriteTeam")
//        }
//    }
//
//    @Published var sendPush: Bool {
//        didSet {
//            UserDefaults.standard.set(sendPush, forKey: "sendPush")
//        }
//    }
//
//    public var skylarksTeams = ["Team 1",
//                                "Softball",
//                                "Team 2",
//                                "Team 3",
//                                //"Team 4",
//                                "Jugend",
//                                "Schüler",
//                                //"Tossball",
//                                "Teeball" ]
//
//    init() {
//        self.favoriteTeam = UserDefaults.standard.object(forKey: "favoriteTeam") as? String ?? "Team 1"
//        self.sendPush = UserDefaults.standard.object(forKey: "sendPush") as? Bool ?? false
//    }
//}

struct SettingsListView: View {
    
    //@ObservedObject var userSettings = UserSettings()
   
    @State var teams = [BSMTeam]()
    
    @AppStorage("selectedSeason") var selectedSeason = Calendar(identifier: .gregorian).dateComponents([.year], from: .now).year!
    @AppStorage("favoriteTeam") var favoriteTeam: String = "Not set"
    
    @AppStorage("favoriteTeamID") var favoriteTeamID = 0
    
    func fetchTeams() async {
        do {
            teams = try await loadSkylarksTeams(season: selectedSeason)
        } catch {
            print("Request failed with error: \(error)")
        }
    }
    
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
                Picker(selection: $selectedSeason, label:
                    HStack {
                        Image(systemName: "deskclock.fill")
                            .font(.title3)
                        Text("Season")
                }) {
                    //TODO: change to start with 2021 (app does not work with older team names)
                    ForEach(2015...Calendar(identifier: .gregorian).dateComponents([.year], from: .now).year!, id: \.self) { season in
                        Text(String(season))
                    }
                }
            }
            Section(
                header: Text("Teams"),
                footer: Text("Your favorite team appears in the Home dashboard tab.")) {
                    Picker(selection: $favoriteTeamID, label:
                        HStack {
                            Image(systemName: "star.square.fill")
                                .font(.title2)
                            Text("Favorite Team")
                    }) {
                        ForEach(teams, id: \.self) { team in
                            if !team.league_entries.isEmpty {
                                Text("\(team.name) (\(team.league_entries[0].league.name))")
                                    .tag(team.id)
                            }
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
                HStack {
                    Image(systemName: "network")
                    Link("Visit the team website", destination: URL(string: "https://www.tib-baseball.de")!)
                }
                HStack {
                    Image(systemName: "envelope.fill")
                        //.font(.title3)
                    Link("Contact the developer", destination: URL(string: "mailto:app@tib-baseball.de")!)
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
        
        .onAppear(perform: {
            Task {
                await fetchTeams()
            }
        })
        
        .onChange(of: selectedSeason, perform: { value in
            favoriteTeamID = 0
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
