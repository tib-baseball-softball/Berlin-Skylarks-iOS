//
//  StreakBar.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 24.05.22.
//

import SwiftUI
import Charts

struct StreakBar: View {
    @Environment(HomeViewModel.self) var vm: HomeViewModel
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var itemWidth: CGFloat {
        if horizontalSizeClass == .compact {
            return 25
        } else {
            return 35
        }
    }
    
    var body: some View {
        let data = vm.createStreakDataEntries()
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
                Text(vm.tableRow.streak)
                    .font(.title)
                    .bold()
                    .padding(.bottom)
            }
        }
    }
}

#Preview {
    StreakBar()
        .environment(HomeViewModel())
}
