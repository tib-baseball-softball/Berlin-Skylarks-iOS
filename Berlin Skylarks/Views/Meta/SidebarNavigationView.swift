//
//  SidebarNavigationView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 07.11.21.
//

import SwiftUI

struct SidebarNavigationView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Dashboard")) {
                        NavigationLink(
                            destination: UserHomeView()) {
                                HStack {
                                    Image(systemName: "star.square.fill")
                                        .foregroundColor(.skylarksDynamicNavySand)
                                        .frame(width: 30)
                                    Text("Home")
                                        .frame(width: 100, alignment: .leading)
                                }
                        }
                    }
                    Section(header: Text("Game Action")) {
                        NavigationLink(
                            //destination: TestView()) {
                            destination: ScoresView()) {
                                Image(systemName: "42.square.fill")
                                    .foregroundColor(.skylarksDynamicNavySand)
                                    .frame(width: 30)
                                Text("Scores")
                                    .frame(width: 100, alignment: .leading)
                        }
                        NavigationLink(
                            destination: StandingsView()) {
                                Image(systemName: "tablecells.fill")
                                    .foregroundColor(.skylarksDynamicNavySand)
                                    .frame(width: 30)
                                Text("Standings")
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
                                Text("Club")
                                    .frame(width: 100, alignment: .leading)
                        }
                    }
                    Section(header: Text("Preferences")) {
                        NavigationLink(
                            destination: SettingsListView()) {
                                Image(systemName: "gearshape.fill")
                                    .foregroundColor(.skylarksDynamicNavySand)
                                    .frame(width: 30)
                                Text("Settings")
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
                
                
            }
            .background(Color(UIColor.systemGroupedBackground))
            Text("Please select a category")
            
            //MARK: this creates a third column
            Text("Please select an app section")
        }
    }
}

struct SidebarNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarNavigationView()
    }
}
