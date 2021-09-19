//
//  StandingsView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.12.20.
//

//this is the overview table where the desired league is selected to display standings

import SwiftUI

//these need to be changed every year after the schedule is published - there is no option to collect all tables for Skylarks teams like I do with scores

let urlVLBB = URL(string:"https://bsm.baseball-softball.de/leagues/4800/table.json")!

let urlVLSB = URL(string:"https://bsm.baseball-softball.de/leagues/4805/table.json")!

let urlLLBB = URL(string:"https://bsm.baseball-softball.de/leagues/4801/table.json")!

let urlBZLBB = URL(string:"https://bsm.baseball-softball.de/leagues/4802/table.json")!

let urlSchBB = URL(string:"https://bsm.baseball-softball.de/leagues/4804/table.json")!

let urlTossBB = URL(string:"https://bsm.baseball-softball.de/leagues/4807/table.json")!

let StandingsRowPadding: CGFloat = 10

let leagues = ["Verbandsliga Baseball", "Verbandsliga Softball", "Landesliga Baseball", "Bezirksliga Baseball", "Schülerliga", "Tossballliga" ]


struct StandingsView: View {
    
    //var leagueTable: LeagueTable
    //@State private var leagueTable = LeagueTable()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Please select your league")) {
                    ForEach(leagues, id: \.self) { league in
                        
                        //beware hacky stuff
                        
                        NavigationLink(
                            destination: StandingsTableView(league: league),
                            label: {
                                HStack {
                                    Image(systemName: "tablecells")
                                        .padding(.trailing, 3)
                                        .foregroundColor(Color.accentColor)
                                    Text(league)
                                }
                            })
                    }
                    .padding(StandingsRowPadding)
                }
                
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Standings")
        }
        
    }
}

//extension StandingsView {
//    func loadTableData(url: URL) {
//
//            let request = URLRequest(url: url)
//            URLSession.shared.dataTask(with: request) { data, response, error in
//
//                if let data = data {
//                    if let response_obj = try? JSONDecoder().decode(LeagueTable.self, from: data) {
//
//                        DispatchQueue.main.async {
//                            leagueTable = response_obj
//                        }
//                    }
//                }
//            //isLoadingScores = false
//            }.resume()
//    }
//}

struct StandingsView_Previews: PreviewProvider {
    static var previews: some View {
        StandingsView()
    }
}
