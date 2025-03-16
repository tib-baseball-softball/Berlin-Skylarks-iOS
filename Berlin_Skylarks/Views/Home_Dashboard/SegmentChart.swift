//
//  SegmentChart.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 23.05.22.
//

import SwiftUI
import Charts

struct SegmentChart: View {
    
    @ObservedObject var userDashboard: UserDashboard
    
    #if !os(macOS)
    let showShortenedTeamName = UIDevice.current.userInterfaceIdiom != .phone
    #else
    let showShortenedTeamName = false
    #endif
    
    var body: some View {
        Section(
            header: Text("Visual Chart of Wins count"),
            footer: Text("The chart shows the absolute number of wins in the league selected.")
        ){
            Chart {
                ForEach(userDashboard.leagueTable.rows, id: \.self) { row in
                    BarMark(
                        x: .value("Team Name", showShortenedTeamName ? row.short_team_name : row.team_name),
                        y: .value("Wins Count", row.wins_count)
                    )
                    .foregroundStyle(row.team_name.contains("Skylarks") ? Color.skylarksRed : Color.skylarksDynamicNavySand)
                }
            }
            .padding(.vertical)
        }
    }
}

struct SegmentChart_Previews: PreviewProvider {
    static var previews: some View {
        List {
            SegmentChart(userDashboard: UserDashboard())
        }
        //.preferredColorScheme(.dark)
    }
}
