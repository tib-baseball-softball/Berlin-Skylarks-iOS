//
//  SegmentChart.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 23.05.22.
//

import SwiftUI

struct SegmentChart: View {
    
    @ObservedObject var userDashboard: UserDashboard
    
    private func getColumnHeight(row: LeagueTable.Row) -> CGFloat {
        let newInt = row.wins_count * 10
        let height = CGFloat(newInt)
        return height
    }
    
    var body: some View {
        Section(
            header: Text("Visual Chart of Wins count"),
            footer: Text("The chart shows the absolute number of wins in the league selected.")
        ){
            ScrollView(.horizontal) {
                VStack {
                    HStack(alignment: .bottom) {
                        Spacer()
                        ForEach(userDashboard.leagueTable.rows, id: \.self) { row in
                            let height = getColumnHeight(row: row)
                            ChartElement(tableRow: row, height: height)
                                .foregroundColor(row.team_name.contains("Skylarks") ? Color.accentColor : Color.primary)
                                .padding(.horizontal, 8)
                        }
                    }
                    Divider()
                        .offset(x: 0, y: -55)
                }
            }
        }
    }
}

struct SegmentChart_Previews: PreviewProvider {
    static var previews: some View {
        List {
            SegmentChart(userDashboard: UserDashboard())
        }
        .preferredColorScheme(.dark)
    }
}
