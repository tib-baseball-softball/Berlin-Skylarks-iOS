//
//  StandingsView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.12.20.
//

//this is the overview table where the desired league is selected to display standings

import SwiftUI

let StandingsRowPadding: CGFloat = 10

let leagues = ["Verbandsliga Baseball", "Verbandsliga Softball", "Landesliga Baseball", "Bezirksliga Baseball", "Schülerliga", "Tossballliga" ]

var allLeagueTables: [LeagueTable] = [ ]

//I need to somehow pass the information about the correct league

struct StandingsView: View {
    
    //var leagueTable: LeagueTable
    //@State var leagueTable: LeagueTable
    
    func loadAllTables() {
        for (url) in leagueTableArray {
            loadTableData(url: url)
        }
        print(leagueTable)
    }
    
    var body: some View {
        self.loadAllTables()
        return
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
            }.resume()
    }
}

struct StandingsView_Previews: PreviewProvider {
    static var previews: some View {
        StandingsView()
    }
}
