//
//  SegmentPercentage.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 23.05.22.
//

import SwiftUI

struct SegmentPercentage: View {
    var row: LeagueTable.Row
    
    private func getPercentage() -> CGFloat {
        let percentage = CGFloat((row.quota as NSString).floatValue)
        return percentage
    }
    
    var body: some View {
        Section(
            header: Text("Rank")
        ){
            HStack {
                Spacer()
                if row.rank == "1." {
                    Image(systemName: "crown")
                        .foregroundColor(Color.skylarksRed)
                        .padding(.horizontal)
                }
                Text("\(row.rank)")
                    .bold()
                    .padding(.horizontal)
                Spacer()
            }
            .padding()
            .font(.largeTitle)
        }
        Section(
            header: Text("Wins/Losses")
        ){
            HStack {
                Spacer()
                Text("\(Int(row.wins_count))")
                    .bold()
                    .padding(.horizontal)
                Text("-")
                    .bold()
                Text("\(Int(row.losses_count))")
                    .bold()
                    .padding(.horizontal)
                Spacer()
            }
            .font(.largeTitle)
            .padding()
        }
        let percentage = getPercentage()
        Section(
            header: Text("Winning Percentage")
        ){
            HStack {
                Spacer()
                LargePercentageCircle(percentage: percentage, percentageText: row.quota)
                Spacer()
            }
        }
    }
}

#Preview {
    SegmentPercentage(row: emptyRow)
}
