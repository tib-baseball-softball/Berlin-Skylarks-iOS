//
//  PlayersView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 25.12.20.
//

import SwiftUI

let previewImageSize: CGFloat = 50.0
let SpacerWidth: CGFloat = 15

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
    
    var team: BSMTeam
    
    var body: some View {
        List {
            Section(header: Text("Team data")) {
                HStack {
                    Image(systemName: "person.3.fill")
                    Text(team.name)
                }
                .padding(.vertical)
                if !team.league_entries.isEmpty {
                    HStack {
                        Image(systemName: "list.number")
                        Text(team.league_entries[0].league.name)
                    }
                    .padding(.vertical)
                    HStack {
                        Image(systemName: "calendar")
                        Text(String(team.league_entries[0].league.season))
                    }
                    .padding(.vertical)
                    HStack {
                        Image(systemName: "ticket")
                        Text(String(team.league_entries[0].league.sport))
                    }
                    .padding(.vertical)
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
                        .padding(.vertical)
                    }
                }
            }
            Section(header: Text("Player profiles")) {
                NavigationLink(destination: Text("Player List here")) {
                    HStack {
                        Image(systemName: "person.3.sequence.fill")
                        Text("Show Player List")
                    }
                    .padding(.vertical)
                }
            }
            Section(header: Text("Standings")) {
                Text("temp")
                    .padding(.vertical)
            }
        }
        .navigationTitle(team.name)
        .listStyle( {
          #if os(watchOS)
            .automatic
          #else
            .insetGrouped
          #endif
        } () )
    }
}

struct TeamPlayersView_Previews: PreviewProvider {
    static var previews: some View {
        TeamDetailView(team: emptyTeam)
    }
}
