//
//  StandingsView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.12.20.
//

//this is the overview table where the desired league is selected to display standings

import SwiftUI

struct StandingsView: View {
    
    @State private var leagueTableArray = [LeagueTable]()
    
    @State var tablesLoaded = false
    @State private var loadingInProgress = false
    
    func loadAllTables() {
        
        loadingInProgress = true
        
        for index in 0..<leagueTableURLs.count {
            loadBSMData(url: leagueTableURLs[index], dataType: LeagueTable.self) { loadedSingleTable in
                leagueTableArray.append(loadedSingleTable)
                loadingInProgress = false
            }
        }
    }
    
    var body: some View {
        List {
            Section(header: Text("Please select your league")) {
                if loadingInProgress == true {
                    LoadingView()
                } else {
                    ForEach(leagueTableArray, id: \.self) { LeagueTable in
                        
                        //beware hacky stuff
                        
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
        #if !os(macOS)
        .refreshable {
            leagueTableArray = []
            loadAllTables()
        }
        #endif
        
        .listStyle( {
          #if os(watchOS)
            .automatic
          #else
            .insetGrouped
          #endif
        } () )
        
        .navigationTitle("Standings" + " " + currentSeason)
        
        //Fix on iPhone seems to work for now even without a container view, please double-check in practice!
        
        .onAppear(perform: {
            if leagueTableArray == [] && tablesLoaded == false {
                loadAllTables()
                tablesLoaded = true
            }
        })
    }
}

struct StandingsView_Previews: PreviewProvider {
    static var previews: some View {
        StandingsView()
    }
}
