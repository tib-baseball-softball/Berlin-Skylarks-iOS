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
                    Text("...WORK IN PROGRESS...")
                    if selection == Segment.chart {
                        Section(
                            header: Text("Stuff"),
                            footer: Text("more Stuff")
                        ){
                            Text("Chart here")
                        }
                    } else if selection == Segment.percentage {
                        Section(
                            header: Text("Winning Percentage")
                            //footer: Text("more Stuff")
                        ){
                            VStack {
                                HStack {
                                    Spacer()
                                    Circle()
                                        .strokeBorder(
                                            LinearGradient(gradient: Gradient(colors: [.skylarksBlue, .skylarksRed]), startPoint: .leading, endPoint: .bottomTrailing)
                                            ,
                                            lineWidth: 15
                                        )
                                        .frame(width: 150, height: 150)
                                        .padding()
                                    Spacer()
                                }
                                Text(userDashboard.tableRow.quota)
                            }
                        }
                        AngularGradient(colors: [.skylarksSand, .skylarksBlue, .skylarksRed], center: .center, startAngle: .zero, endAngle: .degrees(360))
                        RadialGradient(colors: [.skylarksSand, .skylarksBlue, .skylarksRed], center: .center, startRadius: 50, endRadius: 100)
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
            HomeTeamDetailView(userDashboard: dummyDashboard)
            .preferredColorScheme(.dark)
        }
    }
}
