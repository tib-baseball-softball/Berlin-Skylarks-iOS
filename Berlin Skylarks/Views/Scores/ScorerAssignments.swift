//
//  ScorerAssignments.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 06.06.22.
//

import SwiftUI

struct ScorerAssignments: View {
    
    var gamescore: GameScore
    
    var body: some View {
        if gamescore.scorer_assignments != [] {
            ForEach(gamescore.scorer_assignments, id: \.self) { scorerEntry in
                HStack {
                    Image(systemName: "pencil")
                    Text(scorerEntry.license.person.last_name + ", " + scorerEntry.license.person.first_name)
                    Spacer()
                    Text(scorerEntry.license.number)
                        .iOS { $0.font(.caption) }
                }.padding(ScoresItemPadding)
            }
        } else {
            HStack {
                Image(systemName: "pencil")
                Text("No scorer assigned yet")
                Spacer()
            }.padding(ScoresItemPadding)
        }
    }
}

struct ScorerAssignments_Previews: PreviewProvider {
    static var previews: some View {
        ScorerAssignments(gamescore: testGame)
    }
}
