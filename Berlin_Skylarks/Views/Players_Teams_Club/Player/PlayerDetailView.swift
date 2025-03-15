//
//  PlayerDetailView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.12.24.
//

import SwiftUI

struct PlayerDetailView: View {
    let player: Components.Schemas.Player

    var body: some View {
        List {
            Section {
                PlayerHeaderView(player: player)
            }
            .listRowSeparatorTint(.skylarksDynamicNavySand)

            Section(header: Text("Player Data")) {
                PlayerMetaView(player: player)
            }
            .listRowSeparatorTint(.skylarksDynamicNavySand)

            Section(header: Text("On the Field")) {
                PlayerFieldView(player: player)
            }
            .listRowSeparatorTint(.skylarksDynamicNavySand)
        }
        .navigationTitle("Player Details")
        #if !os(macOS)
            .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    PlayerDetailView(
        player: .init(
            uid: 3, pid: 3, fullname: "John Doe", firstname: "John",
            lastname: "Doe", birthday: 104_915_689, number: "42",
            throwing: "Left", batting: "Right",
            bsmId: 0, teams: []))
}
