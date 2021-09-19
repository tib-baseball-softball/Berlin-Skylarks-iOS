//
//  StandingsTableView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 10.08.21.
//

import SwiftUI

let teamPadding: CGFloat = 4

//the only way I manged to get this to work is via this global variable. Check if it can be moved to local

var leagueTable: LeagueTable = dummyLeagueTable

//this View is a single table with ONE league. it can be accessed by tapping the corresponding league in StandingsView

struct StandingsTableView: View {
    
    var league: String
    //var leagueTable: LeagueTable
    
    @State var leagueURLSelected = urlLLBB
    
    // no idea if this is actually needed here
    
    //@State private var leagueTables = [LeagueTable]()
    
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
                            .frame(width: 21, height: 20, alignment: .center)
                        Text("L ")
                            .bold()
                            .frame(width: 21, height: 20, alignment: .center)
                        Text("%")
                            .bold()
                            .frame(width: 27, height: 20, alignment: .center)
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
                                .frame(width: 36, height: 20, alignment: .center)
                            Text(String(tableRow.games_behind))
                                .frame(width: 24, height: 20, alignment: .center)
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
        
        .onAppear(perform: { loadTableData(url: leagueURLSelected) })
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
        StandingsTableView(league: leagues[0])

    }
}
