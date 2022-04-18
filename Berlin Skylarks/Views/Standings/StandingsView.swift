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
    
    @State private var leagueTableArray = [LeagueTable]()
    @State var leagueGroups = [LeagueGroup]()
    
    @State var tablesLoaded = false
    @State private var loadingInProgress = false
    
    @AppStorage("selectedSeason") var selectedSeason = Calendar(identifier: .gregorian).dateComponents([.year], from: .now).year!
    
    func loadAllTables() async {
        
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
                print("Request failed with error: \(error)")
            }
        }
        loadingInProgress = false
    }
    
    var body: some View {
        ZStack {
            #if !os(watchOS)
            Color(colorScheme == .light ? .secondarySystemBackground : .systemBackground)
                .edgesIgnoringSafeArea(.all)
            #endif
            List {
                //Text(leagueGroups.debugDescription)
                Section(header: Text("Please select your league")) {
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
                                        Text(LeagueTable.league_name)
                                    }
                                })
                        }
                        .padding()
                    }
                    if loadingInProgress == false && leagueTableArray == [] {
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
            
            .navigationTitle("Standings" + " " + String(selectedSeason))
            
            //Fix on iPhone seems to work for now even without a container view, please double-check in practice!
            
            .onAppear(perform: {
                if leagueTableArray == [] && tablesLoaded == false {
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
        }
    }
}

struct StandingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StandingsView()
            //.preferredColorScheme(.dark)
            //.previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
