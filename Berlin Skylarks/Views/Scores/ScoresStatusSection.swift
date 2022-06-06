//
//  ScoresStatusSection.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 06.06.22.
//

import SwiftUI

struct ScoresStatusSection: View {
    var gamescore: GameScore
    
    var body: some View {
        HStack {
            Image(systemName: "text.justify")
            Text("\(gamescore.human_state)")
        }
        .padding(ScoresItemPadding)
        
        if let scoresheetURL = gamescore.scoresheet_url {
            HStack {
                Image(systemName: "doc.fill")
                Link("Link to Scoresheet", destination: URL(string: scoresheetURL)!)
            }
            .padding(ScoresItemPadding)
        } else {
            HStack {
                Image(systemName: "doc.fill")
                Text("Scoresheet unavailable")
            }
            .padding(ScoresItemPadding)
        }
    }
}

struct ScoresStatusSection_Previews: PreviewProvider {
    static var previews: some View {
        ScoresStatusSection(gamescore: testGame)
    }
}
