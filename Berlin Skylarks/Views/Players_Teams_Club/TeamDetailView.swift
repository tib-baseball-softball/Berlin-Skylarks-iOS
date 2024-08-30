//
//  TeamDetailView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 25.12.20.
//

import SwiftUI

struct PlayerDetailListHeader: View {
    var body: some View {
        HStack {
            Image(systemName: "photo")
            Spacer()
            Text("Name")
            Spacer()
            Text("Jersey Number")
        }
    }
}

struct TeamDetailView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var team: BSMTeam
    let listRowPadding:CGFloat = 3
    
    var body: some View {
        ZStack {
            #if !os(watchOS)
//            Color(colorScheme == .light ? .secondarySystemBackground : .systemBackground)
//                .edgesIgnoringSafeArea(.all)
            #endif
            List {
                Section(header: Text("Team data")) {
                    HStack {
                        Image(systemName: "person.3.fill")
                        Text(team.name)
                    }
                    .padding(.vertical, listRowPadding)
                    if !team.league_entries.isEmpty {
                        HStack {
                            Image(systemName: "list.number")
                            Text(team.league_entries[0].league.name)
                        }
                        .padding(.vertical, listRowPadding)
                        HStack {
                            Image(systemName: "calendar")
                            Text(String(team.league_entries[0].league.season))
                        }
                        .padding(.vertical, listRowPadding)
                        HStack {
                            LicenseSportIndicator(baseball: team.league_entries[0].league.sport.contains("Baseball") ? true : false)
                            Text(String(team.league_entries[0].league.sport))
                        }
                        .padding(.vertical, listRowPadding)
                        //check if there is ever a need to display the classification separately - it's usually the same as the league name
    //                    HStack {
    //                        Image(systemName: "calendar")
    //                        Text(String(team.league_entries[0].league.classification))
    //                    }
    //                    .padding(.vertical, ScoresItemPadding)
                        if let ageGroup = team.league_entries[0].league.age_group {
                            HStack {
                                Image(systemName: "note")
                                Text(String(ageGroup))
                            }
                            .padding(.vertical, listRowPadding)
                        }
                    }
                }
                //MARK: maybe for a later feature (needs to be blocked for general public as player lists are sensitive data)
//                Section(header: Text("Player profiles")) {
//                    NavigationLink(destination: Text("Player List here")) {
//                        HStack {
//                            Image(systemName: "person.3.sequence.fill")
//                            Text("Show Player List")
//                        }
//                        .padding(.vertical)
//                    }
//                }
//                Section(header: Text("Standings")) {
//                    Text("temp")
//                        .padding(.vertical)
//                }
            }
            .navigationTitle(team.name)
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .frame(maxWidth: 600)
        }
    }
}

struct TeamPlayersView_Previews: PreviewProvider {
    static var previews: some View {
        TeamDetailView(team: emptyTeam)
    }
}
