//
//  UmpireAssignments.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 06.06.22.
//

import SwiftUI

struct UmpireAssignments: View {
    
    var gamescore: GameScore
    
    var body: some View {
        ForEach(gamescore.umpire_assignments, id: \.self) { umpireEntry in
            HStack {
                Image(systemName: "person.fill")
                Text(umpireEntry.license.person.last_name + ", " + umpireEntry.license.person.first_name)
                Spacer()
                Text(umpireEntry.license.number)
                .iOS { $0.font(.caption) }
            }.padding(ScoresItemPadding)
        }
        
        if !gamescore.umpire_assignments.indices.contains(0) {
            HStack {
                Image(systemName: "person.fill")
                Text("No first umpire assigned yet")
                Spacer()
            }.padding(ScoresItemPadding)
        }
        
        if !gamescore.umpire_assignments.indices.contains(1) {
            HStack {
                Image(systemName: "person.fill")
                Text("No second umpire assigned yet")
                Spacer()
            }.padding(ScoresItemPadding)
        }
    }
}

struct UmpireAssignments_Previews: PreviewProvider {
    static var previews: some View {
        UmpireAssignments(gamescore: testGame)
    }
}
