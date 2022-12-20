//
//  SettingsListView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 27.12.20.
//

import SwiftUI

struct SettingsListView: View {
    
    @EnvironmentObject var networkManager: NetworkManager
    @State private var showAlertNoNetwork = false
   
    @State var teams = [BSMTeam]()
    
    @State var showingSheetTeams = false
    
    @AppStorage("selectedSeason") var selectedSeason = Calendar(identifier: .gregorian).dateComponents([.year], from: .now).year!
    //@AppStorage("favoriteTeam") var favoriteTeam: String = "Not set"
    
    @AppStorage("favoriteTeamID") var favoriteTeamID = 0
    
    let mailtoUrl = URL(string: "mailto:app@tib-baseball.de")!
    
    func fetchTeams() async {
#if !os(watchOS)
        if networkManager.isConnected == false {
            showAlertNoNetwork = true
        }
#endif
        
        do {
            teams = try await loadSkylarksTeams(season: selectedSeason)
        } catch {
            print("Request failed with error: \(error)")
        }
    }
    
    func getLanguageCode() -> String {
        if Locale.autoupdatingCurrent.language.languageCode?.identifier == "de" {
            return "de"
        } else {
            return "en"
        }
    }
    
    var body: some View {
        List {
            Section(
                header: Text("Time Range"),
                footer: Text("The selected season is applied globally in the app.")
            ) {
                Picker(selection: $selectedSeason, label:
                        HStack {
                    Image(systemName: "deskclock.fill")
                        .font(.title3)
                    Text("Season")
                }
                    .listRowBackground(ColorStandingsTableHeadline)
                ) {
                    //theoretically works with years earlier than 2021, but the app filters games for team name, so older team names don't work in the current implementation and are not intended to be included
                    ForEach(2021...Calendar(identifier: .gregorian).dateComponents([.year], from: .now).year!, id: \.self) { season in
                        //not using string interpolation here because it adds weird formatting upon conversion!
                        Text(String(season))
                    }
                }
#if !os(watchOS)
                .pickerStyle(.inline)
#endif
            }
            Section(
                header: Text("Teams"),
                footer: Text("Your favorite team appears in the Home dashboard tab.")) {
                    Button(action: {
                        showingSheetTeams = true
                    }, label: {
                        HStack {
                            Image(systemName: "star.square.fill")
                                .font(.title2)
                            Text("Favorite Team")
                        }
                    })
            }
            Section(header: Text("Information")) {
                //App info does not show anything on watchOS, so we don't need to show it there
#if !os(watchOS)
                NavigationLink(
                    destination: InfoView()) {
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .font(.title3)
                            .frame(width: 25)
                        Text("App Info")
                    }
                }
#endif
                let code = getLanguageCode()
                
                NavigationLink(
                    destination: LegalNoticeView(languageCode: code)) {
                    HStack {
                        Image(systemName: "c.circle")
                            .font(.title2)
                            .frame(width: 25)
                        Text("Legal Notice")
                    }
                }
                NavigationLink(
                    destination: PrivacyPolicyView(languageCode: code)) {
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
            teams = []
            showingSheetTeams = true
            Task {
                await fetchTeams()
            }
        })
        
        .sheet(isPresented: $showingSheetTeams, content: {
            SelectTeamSheet()
        })
        
        .alert("No network connection", isPresented: $showAlertNoNetwork) {
            Button("OK") { }
        } message: {
            Text("No active network connection has been detected. The app needs a connection to download its data.")
        }
    }
}

struct SettingsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsListView()
        }
        //.preferredColorScheme(.dark)
        .environmentObject(NetworkManager())
    }
}
