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
#if !os(watchOS)
                    .font(.title2)
                    .foregroundColor(.skylarksDynamicNavySand)
#else
                    .font(.title3)
                    .foregroundColor(.skylarksSand)
#endif
                Text(LocalizedStringKey(itemName))
                    .fixedSize()
#if !os(watchOS)
                    .font(.headline)
#else
                    .font(.footnote)
#endif
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
