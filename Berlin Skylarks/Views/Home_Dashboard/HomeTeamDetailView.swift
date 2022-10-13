//
//  HomeTeamDetailView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 18.04.22.
//

import SwiftUI

struct HomeTeamDetailView: View {
    
    //Ideas: chart with wins/percentage gauge/"hot and cold streak"
    
    enum Segment: String, Identifiable, CaseIterable {
        case chart, percentage, streak
        
        var displayName: String { rawValue.capitalized }
        var id: String { self.rawValue }
    }
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var userDashboard: UserDashboard
    
    @State var selection = Segment.percentage
    
    var body: some View {
        ZStack {
            Color(colorScheme == .light ? .secondarySystemBackground : .systemBackground)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Picker(selection: $selection, label:
                        Text("Selected section")
                ){
                    ForEach(Segment.allCases) { segment in
                        Text(segment.displayName)
                            .tag(segment)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                List {
                    if selection == Segment.chart {
                        SegmentChart(userDashboard: userDashboard)
                    } else if selection == Segment.percentage {
                        SegmentPercentage(userDashboard: userDashboard)
                    } else if selection == Segment.streak {
                        SegmentStreak(userDashboard: userDashboard)
                    }
                }
                .listStyle(.insetGrouped)
                .navigationTitle("Favorite Team Details")
                .animation(.easeInOut, value: selection)
                
    //            .toolbar {
    //                ToolbarItemGroup(placement: .bottomBar) {
    //                    Picker(selection: $selection, label:
    //                            Text("Selected section")
    //                    ){
    //                        ForEach(Segment.allCases) { segment in
    //                            Text(segment.displayName)
    //                                .tag(segment)
    //                        }
    //                    }
    //                    .pickerStyle(.segmented)
    //                }
    //            }
            }
        }
    }
}

struct HomeTeamDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeTeamDetailView(userDashboard: UserDashboard())
            //.preferredColorScheme(.dark)
        }
    }
}
