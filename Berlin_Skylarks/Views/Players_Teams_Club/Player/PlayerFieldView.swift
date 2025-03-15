//
//  PlayerFieldView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.12.24.
//

import SwiftUI

struct PlayerFieldView: View {
    let player: Components.Schemas.Player

    var body: some View {
        InfoRow(
            iconName: "baseball.diamond.bases", title: "Field Positions",
            value: player.positions?.joined(separator: ", ") ?? "None")
        InfoRow(
            iconName: "baseball", title: "Throws",
            value: player.throwing)
        InfoRow(
            iconName: "figure.baseball", title: "Bats", value: player.batting)
    }
}
