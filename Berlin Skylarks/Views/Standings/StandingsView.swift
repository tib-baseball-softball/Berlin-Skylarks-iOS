//
//  StandingsView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.12.20.
//

//this is the overview table where the desired league is selected to display standings

import SwiftUI

struct StandingsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var networkManager: NetworkManager
    @State private var showAlertNoNetwork = false
    
    @State private var leagueTableArray = [LeagueTable]()
    @State var leagueGroups = [LeagueGroup]()
    
    @State var tablesLoaded = false
    @State private var loadingInProgress = false
    
    @StateObject var teamsLoader = TeamsLoader()
    
    @AppStorage("selectedSeason") var selectedSeason = Calendar(identifier: .gregorian).dateComponents([.year], from: .now).year!
    @AppStorage("favoriteTeamID") var favoriteTeamID = 0
    
    func loadAllTables() async {
        if networkManager.isConnected == false {
            showAlertNoNetwork = true
        }
        
        let leagueGroupsURL = URL(string:"https://bsm.baseball-softball.de/league_groups.json?filters[seasons][]=" + "\(selectedSeason)" + "&api_key=" + apiKey)!
        
        loadingInProgress = true
        
        do {
           leagueGroups = try await fetchBSMData(url: leagueGroupsURL, dataType: [LeagueGroup].self)
        } catch {
            print("Request failed with error: \(error)")
        }
        for leagueGroup in leagueGroups {
            let url = URL(string: "https://bsm.baseball-softball.de/leagues/" + "\(leagueGroup.id)" + "/table.json")!
            
            do {
                let table = try await fetchBSMData(url: url, dataType: LeagueTable.self)
                leagueTableArray.append(table)
            } catch {
                print("Request failed with error: \(error) while parsing \(leagueGroup.name) with id \(leagueGroup.id)")
            }
        }
        await teamsLoader.loadTeamData(selectedSeason: selectedSeason)
        
        loadingInProgress = false
    }
    
    var body: some View {
        ZStack {
            #if !os(watchOS)
            Color(colorScheme == .light ? .secondarySystemBackground : .systemBackground)
                .edgesIgnoringSafeArea(.all)
            #endif
            List {
                Section(header:
                    HStack {
                        Text("Club Team Records")
                        Spacer()
                        Text("Season: " + String(selectedSeason))
                },
                        footer: Text("How are our teams doing?")) {
                    if loadingInProgress == false && !leagueTableArray.isEmpty {
                        NavigationLink(destination: ClubStandingsView(leagueTables: leagueTableArray)) {
                            HStack {
                                Image(systemName: "person.3")
                                #if !os(watchOS)
                                    .foregroundColor(.skylarksDynamicNavySand)
                                #else
                                    .foregroundColor(.skylarksSand)
                                #endif
                                Text("See records for all teams")
                            }
                            .padding(.vertical)
                        }
                    } else {
                        LoadingView()
                    }
                    if loadingInProgress == false && leagueTableArray.isEmpty {
                        Text("No team data found.")
                    }
                }
                //Text(leagueGroups.debugDescription)
                Section(header: Text("League Standings"),
                        footer: Text("Please select a league for comprehensive data.")) {
                    if loadingInProgress == true {
                        LoadingView()
                    } else {
                        ForEach(leagueTableArray, id: \.self) { LeagueTable in
                            
                            NavigationLink(
                                destination: StandingsTableView(leagueTable: LeagueTable),
                                label: {
                                    HStack {
                                        Image(systemName: "tablecells")
                                            .padding(.trailing, 3)
                                            .foregroundColor(Color.accentColor)
                                        HStack {
                                            //von hinten durch die Brust ins Auge
                                            let favTeam = teamsLoader.getFavoriteTeam(favID: favoriteTeamID)
                                            Text(LeagueTable.league_name)
                                            if !favTeam.league_entries.isEmpty {
                                                //MARK: check, it might be needed to switch to "contains" should names diverge at some point
                                                if favTeam.league_entries[0].league.name == LeagueTable.league_name {
                                                    Image(systemName: "star")
                                                        .foregroundColor(.skylarksRed)
                                                }
                                            }
                                        }
                                    }
                                })
                        }
                        .padding(.vertical, 2)
                    }
                    if loadingInProgress == false && leagueTableArray.isEmpty {
                        Text("No table data found.")
                    }
                }
            }
            //this doesn't work - still crashes
            .animation(.default, value: leagueTableArray)
            #if !os(macOS)
            .refreshable {
                leagueTableArray = []
                await loadAllTables()
            }
            #endif
            
            .listStyle( {
              #if os(watchOS)
                .automatic
              #else
                .insetGrouped
              #endif
            } () )
            .frame(maxWidth: 600)
            
            .navigationTitle("Standings")
            
            //Fix on iPhone seems to work for now even without a container view, please double-check in practice!
            
            .onAppear(perform: {
                if leagueTableArray.isEmpty && tablesLoaded == false {
                    Task {
                        await loadAllTables()
                    }
                    tablesLoaded = true
                }
            })
            .onChange(of: selectedSeason, perform: { value in
                leagueTableArray = []
                tablesLoaded = false
                //let's try to save some performance - don't need to load twice
                //loadAllTables()
            })
            
            .alert("No network connection", isPresented: $showAlertNoNetwork) {
                Button("OK") { }
            } message: {
                Text("No active network connection has been detected. The app needs a connection to download its data.")
            }
        }
    }
}

struct StandingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StandingsView()
            .preferredColorScheme(.dark)
            //.previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(NetworkManager())
        }
    }
}
