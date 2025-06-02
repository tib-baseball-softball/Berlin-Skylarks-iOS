//
//  HomeTeamDetailView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 18.04.22.
//

import SwiftUI

struct HomeTeamDetailView: View {
    var team: BSMTeam
    var table: LeagueTable
    var row: LeagueTable.Row
    
    enum Segment: String, Identifiable, CaseIterable {
        case chart, percentage, streak
        
        var displayName: String { rawValue.capitalized }
        var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue.capitalized) }
        var id: String { self.rawValue }
    }
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var selection = Segment.percentage
    
    var body: some View {
        VStack {
            Picker(selection: $selection, label:
                    Text("Selected section")
            ){
                ForEach(Segment.allCases) { segment in
                    Text(segment.localizedName)
                        .tag(segment)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            List {
                if selection == Segment.chart {
                    SegmentChart(table: table)
                } else if selection == Segment.percentage {
                    SegmentPercentage(row: row)
                } else if selection == Segment.streak {
                    SegmentStreak(table: table, row: row)
                }
            }
            .navigationTitle("Favorite Team Details")
            .animation(.easeInOut, value: selection)
        }
    }
}

#Preview {
    HomeTeamDetailView(team: emptyTeam, table: emptyTable, row: emptyRow, selection: HomeTeamDetailView.Segment.percentage)
}
