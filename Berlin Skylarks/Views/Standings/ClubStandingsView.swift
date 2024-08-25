//
//  ClubStandingsView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 02.06.22.
//

import SwiftUI

struct ClubStandingsView: View {
    
    var leagueTables: [LeagueTable]
    
    @Environment(\.colorScheme) var colorScheme
    
    func calculateTotalCounts() -> (wins: Int, losses: Int) {
        var winsCount = 0
        var lossesCount = 0
        for leagueTable in leagueTables {
            for row in leagueTable.rows where row.team_name.contains("Skylarks") {
                //these used to be just Ints, but during season 2022 ties were possible in Kinderliga
                winsCount += Int(row.wins_count)
                lossesCount += Int(row.losses_count)
            }
        }
        return (winsCount, lossesCount)
    }
    
    func calculatePercentage(wins: Int, losses: Int) -> CGFloat {
        let winsCount = CGFloat(wins)
        let lossesCount = CGFloat(losses)
        
        if (winsCount + lossesCount) == 0 {
            return 0.0
        }
        return winsCount / (winsCount + lossesCount)
    }
    
    var body: some View {
        ZStack {
            #if !os(watchOS)
//            Color(colorScheme == .light ? .secondarySystemBackground : .systemBackground)
//                .edgesIgnoringSafeArea(.all)
            #endif
            List {
                Section(header: HStack {
                    Text("Club Team Records")
                    Spacer()
                    Text("W/L")
                }) {
                    ForEach(leagueTables, id: \.self) { LeagueTable in
                        ClubStandingsRow(leagueTable: LeagueTable)
                    }
                    .padding(.vertical, 2)
                }
                let totalCounts = calculateTotalCounts()
                Section(header: HStack {
                    Text("Club Total")
                }) {
                    HStack {
                        Spacer()
                        Text("\(totalCounts.wins) - \(totalCounts.losses)")
                        #if !os(watchOS)
                            .font(.largeTitle)
                        #else
                            .font(.title2)
                        #endif
                            .bold()
                        Spacer()
                    }
                    .padding()
                    let percentage = calculatePercentage(wins: totalCounts.wins, losses: totalCounts.losses)
                    let quotaString = String(format: "%.3f", percentage)
                    HStack {
                        Spacer()
                        LargePercentageCircle(percentage: percentage, percentageText: String(quotaString.dropFirst()))
                        Spacer()
                    }
                    .padding()
                }
            }
            .frame(maxWidth: 650)
            .navigationTitle("Team Records")
        }
    }
}

struct ClubStandingsView_Previews: PreviewProvider {
    static var previews: some View {
        ClubStandingsView(leagueTables: [dummyLeagueTable, dummyLeagueTable, dummyLeagueTable, dummyLeagueTable])
    }
}
