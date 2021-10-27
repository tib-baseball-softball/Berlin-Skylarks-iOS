//
//  StandingsView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.12.20.
//

//this is the overview table where the desired league is selected to display standings

import SwiftUI

let StandingsRowPadding: CGFloat = 10

//these need to be changed every year after the schedule is published - there is no option to collect all tables for Skylarks teams like I do with scores

let urlVLBB = URL(string:"https://bsm.baseball-softball.de/leagues/4800/table.json")!
let urlVLSB = URL(string:"https://bsm.baseball-softball.de/leagues/4805/table.json")!
let urlLLBB = URL(string:"https://bsm.baseball-softball.de/leagues/4801/table.json")!
let urlBZLBB = URL(string:"https://bsm.baseball-softball.de/leagues/4802/table.json")!
let urlJugBB = URL(string:"https://bsm.baseball-softball.de/leagues/4804/table.json")!
let urlSchBB = URL(string:"https://bsm.baseball-softball.de/leagues/4804/table.json")!
let urlTossBB = URL(string:"https://bsm.baseball-softball.de/leagues/4807/table.json")!

let leagueTableURLs = [ urlVLBB, urlVLSB, urlLLBB, urlBZLBB, urlSchBB, urlTossBB ]

struct StandingsView: View {
    
    @State private var leagueTableArray = [LeagueTable]()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Please select your league")) {
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
                    .padding(StandingsRowPadding)
                }
                
            }
            .refreshable {
                leagueTableArray = []
                loadAllTables()
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Standings")
        }
        // I can either make this conditional or maybe clear the array below before adding the new values
        .onAppear(perform: {
            if !leagueTableArray.indices.contains(0) {
                loadAllTables()
            }
        })
        
    }
    func loadAllTables() {
        for index in 0..<leagueTableURLs.count {
            loadTableData(url: leagueTableURLs[index])
        }
    }
    private func loadTableData(url: URL) {

            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in

                if let data = data {
                    if let response_obj = try? JSONDecoder().decode(LeagueTable.self, from: data) {

                        DispatchQueue.main.async {
                            leagueTableArray.append(response_obj)
                        }
                    }
                }
            }.resume()
    }
}

struct StandingsView_Previews: PreviewProvider {
    static var previews: some View {
        StandingsView()
    }
}
