//
//  ScoresDetailView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 27.12.20.
//

import SwiftUI

struct ScoresDetailView: View {
    var body: some View {
        Text("Detailed Info about the game")
            .navigationBarTitle("Game #1", displayMode: .inline)
    }
}

struct ScoresDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ScoresDetailView()
    }
}
