//
//  SettingsListView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 27.12.20.
//

import SwiftUI

struct SettingsListView: View {
    
    //@ObservedObject var userSettings = UserSettings()
   
    @State var teams = [BSMTeam]()
    
    @AppStorage("selectedSeason") var selectedSeason = Calendar(identifier: .gregorian).dateComponents([.year], from: .now).year!
    @AppStorage("favoriteTeam") var favoriteTeam: String = "Not set"
    
    @AppStorage("favoriteTeamID") var favoriteTeamID = 0
    
    let mailtoUrl = URL(string: "mailto:app@tib-baseball.de")!
    
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
                    //theoretically works with years earlier than 2021, but the app filters games for team name, so older team names don't work in the current implementation and are not intended to be included
                    ForEach(2021...Calendar(identifier: .gregorian).dateComponents([.year], from: .now).year!, id: \.self) { season in
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
                            .frame(width: 25)
                        Text("App Info")
                    }
                }
                NavigationLink(
                    destination: LegalNoticeView()) {
                    HStack {
                        Image(systemName: "c.circle")
                            .font(.title2)
                            .frame(width: 25)
                        Text("Legal Notice")
                    }
                }
                NavigationLink(
                    destination: PrivacyPolicyView()) {
                    HStack {
                        Image(systemName: "hand.raised.square.fill")
                            .font(.title2)
                            .frame(width: 25)
                        Text("Privacy Policy")
                    }
                }
            }
            Section(header: Text("Get involved")) {
                HStack {
                    Image(systemName: "network")
                        .font(.title3)
                        .frame(width: 25)
                    Link("Visit the team website", destination: URL(string: "https://www.tib-baseball.de")!)
                }
                HStack {
                    Image(systemName: "arrow.triangle.branch")
                        .font(.title3)
                        .frame(width: 25)
                    Link("Contribute on GitHub", destination: URL(string: "https://github.com/Obnoxieux/Berlin-Skylarks")!)
                }
                #if !os(watchOS)
                //watchOS does not support UIApplication
                HStack {
                    Image(systemName: "envelope.fill")
                        //.font(.title3)
                        .frame(width: 25)
                    Button("Contact the developer", action: {
                        if UIApplication.shared.canOpenURL(mailtoUrl) {
                                UIApplication.shared.open(mailtoUrl, options: [:])
                        }
                    })
                }
                #endif
            }
        }
    #if !os(watchOS)
        .listStyle(.insetGrouped)
    #endif
        //Text("Test")
    
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
