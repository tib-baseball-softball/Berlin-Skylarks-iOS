//
//  InfoRow.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.12.24.
//

import SwiftUI

struct InfoRow: View {
    let iconName: String
    let title: String
    let value: String

    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: iconName)
                .foregroundStyle(Color.skylarksRed)
                .frame(width: 15)
            VStack(alignment: .leading) {
                Text(LocalizedStringKey(title))
                    .font(.subheadline)
                    .foregroundStyle(Color.secondary)
                Text(value)
                    .font(.body)
            }
        }
    }
}
