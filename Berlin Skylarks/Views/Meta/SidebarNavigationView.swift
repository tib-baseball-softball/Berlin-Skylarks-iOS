//
//  SidebarNavigationView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 07.11.21.
//

import SwiftUI

struct SidebarNavigationView: View {
    
    var body: some View {
        NavigationSplitView {
            List {
                Section(header: Text("Dashboard")) {
                    NavigationLink(
                        destination: UserHomeView()) {
                            HStack {
                                Image(systemName: "star.square.fill")
                                    .foregroundColor(.skylarksDynamicNavySand)
                                    .frame(width: 30)
                                Text("Home", comment: "main navigation")
                                    .frame(width: 100, alignment: .leading)
                            }
                    }
                }
                Section(header: Text("Game Action")) {
                    NavigationLink(
                        destination: ScoresView()) {
                            Image(systemName: "42.square.fill")
                                .foregroundColor(.skylarksDynamicNavySand)
                                .frame(width: 30)
                            Text("Scores", comment: "main navigation")
                                .frame(width: 100, alignment: .leading)
                    }
                    NavigationLink(
                        destination: StandingsView()) {
                            Image(systemName: "tablecells.fill")
                                .foregroundColor(.skylarksDynamicNavySand)
                                .frame(width: 30)
                            Text("Standings", comment: "main navigation")
                                .frame(width: 100, alignment: .leading)
                    }
                }
                Section(header: Text("About the team")) {
                    //not functional yet
//                        NavigationLink(
//                            destination: NewsView()) {
//                                HStack {
//                                    Image(systemName: "newspaper.fill")
//                                        .frame(width: 30)
//                                    Text("News")
//                                        .frame(width: 100, alignment: .leading)
//                                }
//                        }
                    NavigationLink(
                        destination: ClubView()) {
                            Image(systemName: "shield.fill")
                                .foregroundColor(.skylarksDynamicNavySand)
                                .frame(width: 30)
                            Text("Club", comment: "main navigation")
                                .frame(width: 100, alignment: .leading)
                    }
                }
                Section(header: Text("Preferences")) {
                    NavigationLink(
                        destination: SettingsListView()) {
                            Image(systemName: "gearshape.fill")
                                .foregroundColor(.skylarksDynamicNavySand)
                                .frame(width: 30)
                            Text("Settings", comment: "main navigation")
                                .frame(width: 100, alignment: .leading)
                    }
                }
                HStack {
                    Spacer()
                    Image("Rondell")
                        .resizable()
                        .scaledToFit()
                        .accessibilityLabel("Berlin Skylarks Logo")
                    .frame(width: 150, height: 150, alignment: .center)
                    Spacer()
                }
            }
            .listStyle(.sidebar)
            .navigationSplitViewColumnWidth(ideal: 270)
        } content: {
            Text("Please select a category")
                .navigationSplitViewColumnWidth(min: 200, ideal: 600, max: 800)
        } detail: {
            Text("Please select an app section")
        }
//            }
//            .background(Color(UIColor.systemGroupedBackground))
    }
}

struct SidebarNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarNavigationView()
    }
}
