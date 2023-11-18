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
    
    var itemWidth: CGFloat {
        #if !os(macOS)
        if UIDevice.current.userInterfaceIdiom == .phone {
            return 25
        } else {
            return 35
        }
        #endif
        return 35
    }
    
    var body: some View {
        let data = userDashboard.createStreakDataEntries()
        Section(
            header: Text("Visualization of current season"),
            footer: Text("Hot or cold - how is your team's season going?")
        ){
            VStack {
                ScrollView(.horizontal) {
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
                    .chartXAxisLabel(LocalizedStringKey("Gamedays"))
                    .chartYAxisLabel(LocalizedStringKey("Wins Count"))
                    .padding(.vertical)
                    .frame(width: CGFloat(data.count) * itemWidth)
                }
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
