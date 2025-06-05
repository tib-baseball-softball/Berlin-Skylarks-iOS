//
//  HomeTeamDetailView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 18.04.22.
//

import SwiftUI

struct HomeTeamDetailView: View {
    var dataset: HomeDataset
    
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
                    SegmentChart(table: dataset.leagueTable)
                } else if selection == Segment.percentage {
                    SegmentPercentage(row: dataset.tableRow)
                } else if selection == Segment.streak {
                    SegmentStreak(dataset: dataset)
                }
            }
            .navigationTitle("Favorite Team Details")
            .animation(.easeInOut, value: selection)
        }
    }
}
