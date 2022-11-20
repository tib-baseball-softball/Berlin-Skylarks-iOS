//
//  StreakBar.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 24.05.22.
//

import SwiftUI
import Charts

struct StreakBar: View {
    
    @ObservedObject var userDashboard: UserDashboard
    
    var body: some View {
        let data = userDashboard.createStreakDataEntries()
        Section(
            header: Text("Visualization of current season"),
            footer: Text("Hot or cold - how is your team's season going?")
        ){
            VStack {
                Chart {
                    ForEach(data, id: \.self) { dataEntry in
                        LineMark(x: .value("Gameday", dataEntry.game),
                                 y: .value("Streak", dataEntry.winsCount)
                        )
                        .foregroundStyle(Color.secondary)
                        PointMark(x: .value("Gameday", dataEntry.game),
                                 y: .value("Streak", dataEntry.winsCount)
                        )
                        .foregroundStyle(dataEntry.wonGame ? Color.green : Color.red)
                    }
                }
                .chartXAxisLabel("Gamedays")
                .chartYAxisLabel("Wins Count")
                .padding(.vertical)
                Text(userDashboard.tableRow.streak)
                //Text("W6") //DEBUG
                    .font(.title)
                    .bold()
                    .padding(.bottom)
            }
        }
    }
}

struct StreakBar_Previews: PreviewProvider {
    static var previews: some View {
        List {
            StreakBar(userDashboard: UserDashboard())
        }
    }
}
