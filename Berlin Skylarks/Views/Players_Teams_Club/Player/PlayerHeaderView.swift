//
//  PlayerHeaderView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.12.24.
//

import SwiftUI

struct PlayerHeaderView: View {
    let player: Components.Schemas.Player

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let imageURL = player.media?.first?.url {
                AsyncImage(url: URL(string: imageURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(10)
                } placeholder: {
                    Image("team-placeholder")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(10)
                }
            } else {
                Image("team-placeholder")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(10)
            }

            HStack(spacing: 8) {
                PlayerNumberGraphic(jerseyNumber: player.number)
                Text(player.fullname)
                    .font(.title2)
                    .fontWeight(.bold)
            }
        }
        .padding(.bottom, 8)
    }
}
