//
//  ScoreNumber.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 04.07.22.
//

import SwiftUI

struct ScoreNumber: View {

    var displayScore: Int
    var otherScore: Int

    var body: some View {
        Text(String(displayScore))
            .foregroundColor(
                displayScore < otherScore ? Color.secondary : Color.primary
            )
            //was hidden on Mac, watch if this helps
            .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    ScoreNumber(displayScore: 5, otherScore: 4)
}
