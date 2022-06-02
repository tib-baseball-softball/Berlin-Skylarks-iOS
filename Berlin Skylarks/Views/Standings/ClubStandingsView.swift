//
//  ClubStandingsView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 02.06.22.
//

import SwiftUI

struct ClubStandingsView: View {
    
    var leagueTables: [LeagueTable]
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            #if !os(watchOS)
            Color(colorScheme == .light ? .secondarySystemBackground : .systemBackground)
                .edgesIgnoringSafeArea(.all)
            #endif
            List {
                Section(header: HStack {
                    Text("Club Standings")
                    Spacer()
                    Text("W/L")
                }) {
                    ForEach(leagueTables, id: \.self) { LeagueTable in
                        ClubStandingsRow(leagueTable: LeagueTable)
                    }
                    .padding(.vertical, 2)
                }
            }
            .frame(maxWidth: 650)
            .navigationTitle("Team Records")
        }
    }
}

struct ClubStandingsView_Previews: PreviewProvider {
    static var previews: some View {
        ClubStandingsView(leagueTables: [dummyLeagueTable, dummyLeagueTable, dummyLeagueTable])
    }
}
