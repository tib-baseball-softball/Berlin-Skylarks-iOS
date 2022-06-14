//
//  ClubStandingsRow.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 31.05.22.
//

import SwiftUI

struct ClubStandingsRow: View {
    
    var leagueTable: LeagueTable
    
    var tableRows: [LeagueTable.Row] {
        return leagueTable.rows.filter { $0.team_name.contains("Skylarks") }
    }
    
    var body: some View {
        HStack {
            Image(systemName: "person.3")
            #if !os(watchOS)
                .foregroundColor(.skylarksDynamicNavySand)
            #else
                .foregroundColor(.skylarksSand)
            #endif
            
            Text(leagueTable.league_name)
            
            Spacer()
            
            ForEach(tableRows, id: \.self) { row in
                Text("\(row.wins_count)-\(row.losses_count)")
                    .font(.headline)
            }
        }
    }
}

struct ClubStandingsRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ClubStandingsRow(leagueTable: dummyLeagueTable)
        }
        .preferredColorScheme(.dark)
    }
}
