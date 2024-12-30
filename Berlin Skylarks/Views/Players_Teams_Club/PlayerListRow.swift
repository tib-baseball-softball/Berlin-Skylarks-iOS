//
//  PlayerListRow.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.12.24.
//

import SwiftUI

struct PlayerListRow: View {
    let player: Components.Schemas.Player

    var body: some View {
        HStack {
            if let image = player.media?.first {
                AsyncImage(url: URL(string: image.url)) {
                    loadedImage in
                    loadedImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .accessibilityLabel(
                            image.alt
                                ?? "Image for \(player.fullname)")
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 70)
            } else {
                Image("team-placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70)
                    .accessibilityLabel("Placeholder image")
            }
            VStack(alignment: .leading) {
                Text(player.fullname)
                if let positions = player.positions {
                    Text(
                        positions.joined(
                            separator: ", ")
                    ).font(.caption)
                }
            }
        }
    }
}

#Preview {
    PlayerListRow(
        player: .init(
            uid: 3, pid: 3, fullname: "John Doe", firstname: "John",
            lastname: "Doe", number: "42", throwing: "Left", batting: "Right",
            bsmId: 0, teams: []))
}
