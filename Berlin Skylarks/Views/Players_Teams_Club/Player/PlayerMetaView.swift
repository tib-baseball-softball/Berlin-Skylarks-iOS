//
//  PlayerMetaView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.12.24.
//

import SwiftUI

struct PlayerMetaView: View {
    let player: Components.Schemas.Player

    var body: some View {
        InfoRow(
            iconName: "person.2.fill", title: "Team",
            value: player.teams.map { $0.name ?? "No Team" }.joined(
                separator: ", "))
        if let birthday = player.birthday {
            InfoRow(iconName: "number", title: "Age", value: String(DateTimeUtility.getAge(from: TimeInterval(birthday))))
        }
        InfoRow(
            iconName: "calendar", title: "Member Since",
            value: player.admission ?? "Unknown")
    }
}
