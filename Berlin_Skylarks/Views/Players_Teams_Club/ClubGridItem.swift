//
//  ClubGridItem.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 19.07.22.
//

import SwiftUI

struct ClubGridItem: View {
    @Environment(\.colorScheme) var colorScheme
    
    var systemImage: String
    var itemName: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Image(systemName: systemImage)
                    .font(.title2)
                    .foregroundColor(.skylarksDynamicNavySand)
                Text(LocalizedStringKey(itemName))
                    .fixedSize()
                    .font(.headline)
            }
            Spacer()
        }
        .padding()
        .iOS { $0.background(Color.secondaryBackground) }
        .cornerRadius(15)
    }
}

#Preview {
    ClubGridItem(systemImage: "person.fill", itemName: "Umpire")
}
