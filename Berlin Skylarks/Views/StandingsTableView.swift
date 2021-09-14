//
//  StandingsTableView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 10.08.21.
//

let teamPadding: CGFloat = 4

import SwiftUI

//this is a single table with ONE league. it can be accessed by tapping the corresponding league in StandingsView

struct StandingsTableView: View {
    
    var leagueTable: LeagueTable
    
    @State private var leagueTables = [LeagueTable.Row]()
    
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
                
                ForEach(self.leagueTable.rows, id: \.rank) { tableRow in
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
                                .frame(width: 35, height: 20, alignment: .center)
                            Text(String(tableRow.games_behind))
                                .frame(width: 21, height: 20, alignment: .center)
                            Text(tableRow.streak)
                                .frame(width: 37, height: 20, alignment: .center)
                        }.padding(.horizontal, -8)
                        
                    }
                }
                //more rows here
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Verbandsliga Baseball")
    }
}

struct StandingsTableView_Previews: PreviewProvider {
    static var previews: some View {
        StandingsTableView(leagueTable: dummyLeagueTable)
            
    }
}

//old state with LazyVGrid

//let columns = [
//        GridItem(.flexible(minimum: 20, maximum: 30)),
//        GridItem(.flexible(minimum: 165, maximum: 400)),
//        GridItem(.flexible(minimum: 20, maximum: 30)),
//        GridItem(.flexible(minimum: 20, maximum: 30)),
//        GridItem(.flexible(minimum: 30, maximum: 30))
//    ]
//
//var body: some View {
//    LazyVGrid(columns: columns, spacing: 20) {
//        Group {
//            Text("#")
//                .bold()
//                .font(.title3)
//            Text("Team")
//                .bold()
//                .font(.title3)
//            Text("W")
//                .bold()
//                .font(.title3)
//            Text("L")
//                .bold()
//                .font(.title3)
//            Text("GB")
//                .bold()
//                .font(.title3)
//        }
//        //.foregroundColor(.white)
//        //.background(Color.accentColor)
//        Group {
//            Text("1.")
//            Text("Skylarks")
//            Text("7")
//            Text("2")
//            Text("0")
//        }
//        Group {
//            Text("2.")
//            Text("Sluggers")
//            Text("4")
//            Text("8")
//            Text("3")
//        }
//        Group {
//            Text("3.")
//            Text("SG Sluggers/Roadrunners/Sliders")
//            Text("4")
//            Text("8")
//            Text("3")
//        }
//    }
//    //.padding(.horizontal)
//}
