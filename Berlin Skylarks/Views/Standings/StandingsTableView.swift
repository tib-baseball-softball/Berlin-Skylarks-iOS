//
//  StandingsTableView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 10.08.21.
//

import SwiftUI

//this View is a single table with ONE league. it can be accessed by tapping the corresponding league in StandingsView

struct StandingsTableView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var leagueTable: LeagueTable
    
    var body: some View {
        
        #if os(watchOS)
        
        //------------------------------------------------------------//
        // the table for Apple Watch removes the columns for streak and games behind and changes the team display name to the short name (acronym with number)
        //------------------------------------------------------------//
        
        List {
            Section(footer: Text(
                """
                Legend:
                W: Wins
                L: Losses
                %: Winning Percentage
                """
                )) {
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
                    }.padding(.horizontal, -5)
                }
                .font(.headline)
                
                ForEach(leagueTable.rows, id: \.rank) { tableRow in
                    HStack {
                        Text(tableRow.rank)
                        Text(tableRow.short_team_name)
                            //.padding(.horizontal, teamPadding)
                        Spacer()
                        HStack {
                            Text(String(Int(tableRow.wins_count)))
                                .frame(width: 21, height: 20, alignment: .center)
                            Text(String(Int(tableRow.losses_count)))
                                .frame(width: 21, height: 20, alignment: .center)
                            Text(tableRow.quota)
                                .frame(width: 42, height: 20, alignment: .center)
                        }.padding(.horizontal, -8)
                    }
                    .foregroundColor(tableRow.team_name.contains("Skylarks") ? Color.accentColor : Color.primary)
                }
            }
        }
        .navigationTitle(leagueTable.league_name)
        
        #else
        ZStack {
            #if !os(watchOS) && !os(macOS)
            Color(colorScheme == .light ? .secondarySystemBackground : .systemBackground)
                .edgesIgnoringSafeArea(.all)
            #endif
            List {
                Section(footer: Text(
                """
                Legend:
                W: Wins
                L: Losses
                %: Winning Percentage
                GB: Games Behind (first place, assuming no ties)
                Srk: Streak (winning or losing)
                """
                )) {
                    HStack {
                        Text("#")
                            .bold()
                        Text("Team")
                            .bold()
                        Spacer()
                        HStack {
                            Text("W")
                                .bold()
                                .frame(width: 22, height: 20, alignment: .center)
                            Text("L ")
                                .bold()
                                .frame(width: 30, height: 20, alignment: .center)
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
                    //.foregroundColor(.white)
                    .listRowBackground(ColorStandingsTableHeadline)
                    
                    ForEach(leagueTable.rows, id: \.rank) { tableRow in
                        HStack {
                            Text(tableRow.rank)
                            Text(tableRow.team_name)
                                .padding(.horizontal, 3)
                            Spacer()
                            HStack {
                                Text(String(Int(tableRow.wins_count)))
                                    .frame(width: 21, height: 20, alignment: .center)
                                Text(String(Int(tableRow.losses_count)))
                                    .frame(width: 21, height: 20, alignment: .center)
                                Text(tableRow.quota)
                                    .frame(width: 42, height: 20, alignment: .center)
                                Text(String(tableRow.games_behind))
                                    .fixedSize()
                                    .frame(width: 31, height: 20, alignment: .center)
                                Text(tableRow.streak)
                                    .frame(width: 37, height: 20, alignment: .center)
                                    
                            }
                            .padding(.horizontal, -8)
                        }
                        .foregroundColor(tableRow.team_name.contains("Skylarks") ? Color.accentColor : Color.primary)
                    }
                }
            }
            .frame(maxWidth: 650)
            .listStyle(.insetGrouped)
            .navigationTitle(leagueTable.league_name + " " + String(leagueTable.season))
            #if !os(macOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
        }
        .iOS { $0.background(colorStandingsBackground) }
        #endif
    }
}



struct StandingsTableView_Previews: PreviewProvider {
    static var previews: some View {
        StandingsTableView(leagueTable: dummyLeagueTable)
            //.preferredColorScheme(.dark)
    }
}
