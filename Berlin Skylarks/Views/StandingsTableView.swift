//
//  StandingsTableView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 10.08.21.
//

import SwiftUI

let teamPadding: CGFloat = 4

//these need to be changed every year after the schedule is published - there is no option to collect all tables for Skylarks teams like I do with scores

let urlVLBB = URL(string:"https://bsm.baseball-softball.de/leagues/4800/table.json")!
let urlVLSB = URL(string:"https://bsm.baseball-softball.de/leagues/4805/table.json")!
let urlLLBB = URL(string:"https://bsm.baseball-softball.de/leagues/4801/table.json")!
let urlBZLBB = URL(string:"https://bsm.baseball-softball.de/leagues/4802/table.json")!
let urlSchBB = URL(string:"https://bsm.baseball-softball.de/leagues/4804/table.json")!
let urlTossBB = URL(string:"https://bsm.baseball-softball.de/leagues/4807/table.json")!

let leagueTableArray = [ urlVLBB, urlVLSB, urlLLBB, urlBZLBB, urlSchBB, urlTossBB ]

let leagueTableURLs = [
    "Verbandsliga Baseball": urlVLBB,
    "Verbandsliga Softball": urlVLSB,
    "Landesliga Baseball": urlLLBB,
    "Bezirksliga Baseball": urlBZLBB,
    "Schülerliga": urlSchBB,
    "Tossballliga": urlTossBB,
]

//the only way I manged to get this to work is via this global variable. Check if it can be moved to local

var leagueTable: LeagueTable = dummyLeagueTable

//this View is a single table with ONE league. it can be accessed by tapping the corresponding league in StandingsView

struct StandingsTableView: View {
    
    @State var league: String
    
    //@State var updater: Bool = false
    
    //@State var leagueTable: LeagueTable
    
    @State var leagueURLSelected = urlLLBB
    
    var body: some View {
        List {
            Section {
                HStack {
                    Text("#")
                        .bold()
                    Text("Team")
                        .bold()
                    Spacer()
                    HStack {
                        Text("W")
                            .bold()
                            .frame(width: 24, height: 20, alignment: .center)
                        Text("L ")
                            .bold()
                            .frame(width: 21, height: 20, alignment: .center)
                        Text("%")
                            .bold()
                            .frame(width: 38, height: 20, alignment: .center)
                        Text("GB")
                            .bold()
                            .frame(width: 28, height: 20, alignment: .center)
                        Text("Srk")
                            .bold()
                            .frame(width: 37, height: 20, alignment: .center)
                    }.padding(.horizontal, -10)
                }
                .font(.title3)
                .foregroundColor(.white)
                .listRowBackground(Color.accentColor)
                
                ForEach(leagueTable.rows, id: \.rank) { tableRow in
                    HStack {
                        Text(tableRow.rank)
                        Text(tableRow.team_name)
                            .padding(.horizontal, teamPadding)
                        Spacer()
                        HStack {
                            Text(String(tableRow.wins_count))
                                .frame(width: 21, height: 20, alignment: .center)
                            Text(String(tableRow.losses_count))
                                .frame(width: 21, height: 20, alignment: .center)
                            Text(tableRow.quota)
                                .frame(width: 42, height: 20, alignment: .center)
                            Text(String(tableRow.games_behind))
                                .frame(width: 26, height: 20, alignment: .center)
                            Text(tableRow.streak)
                                .frame(width: 37, height: 20, alignment: .center)
                                
                        }.padding(.horizontal, -8)
                    }
                    .foregroundColor(tableRow.team_name.contains("Skylarks") ? Color.accentColor : Color.primary)
                }
                //more rows here
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(leagueTable.league_name + " " + String(leagueTable.season))
        
//        .onAppear(perform: {
//            for (string, url) in leagueTableURLs {
//                if league.contains(string) {
//                    leagueURLSelected = url
//                }
//            }
//            loadTableData(url: leagueURLSelected)
//            //DEBUG
//            print(leagueTable)
//        })
//
//        .onChange(of: leagueURLSelected, perform: { value in
//            loadTableData(url: leagueURLSelected)
//            //DEBUG
//            print(leagueTable)
//        } )
    }
    private func loadTableData(url: URL) {

            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in

                if let data = data {
                    if let response_obj = try? JSONDecoder().decode(LeagueTable.self, from: data) {

                        DispatchQueue.main.async {
                            leagueTable = response_obj
                        }
                    }
                }
            //isLoadingScores = false
            }.resume()
    }
}

struct StandingsTableView_Previews: PreviewProvider {
    static var previews: some View {
        StandingsTableView(league: leagues[2])

    }
}
