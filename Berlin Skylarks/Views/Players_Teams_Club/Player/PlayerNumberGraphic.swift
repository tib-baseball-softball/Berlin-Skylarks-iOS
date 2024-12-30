//
//  PlayerNumberGraphic.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.12.24.
//

import SwiftUI

struct PlayerNumberGraphic: View {
    var jerseyNumber: String
    
    var body: some View {
        Text(jerseyNumber)
            .padding(8)
            .foregroundStyle(.white)
            .frame(width: 70)
            .background(Color.skylarksRed)
            .font(.largeTitle)
            .clipShape(Circle())
    }
}

#Preview {
    PlayerNumberGraphic(jerseyNumber: "42")
}
