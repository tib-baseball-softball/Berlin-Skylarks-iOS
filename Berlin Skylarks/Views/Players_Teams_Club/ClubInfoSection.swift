//
//  ClubInfoSection.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 19.07.22.
//

import SwiftUI

struct ClubInfoSection: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var clubData: ClubData
    
    var body: some View {
        VStack {
            TeamImageData.skylarksPrimaryLogo
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 100)
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "heart.text.square")
                            .clubIconStyleRed()
                        Text(clubData.club.short_name)
                    }
                    Divider()
                    HStack {
                        Image(systemName: "creditcard")
                            .clubIconStyleRed()
                        Text("\(clubData.club.acronym) / 0\(clubData.club.organization_id) \(clubData.club.number)")
                    }
                    Divider()
                    HStack {
                        Image(systemName: "shield")
                            .clubIconStyleRed()
                        Text(clubData.club.main_club)
                    }
                }
                Spacer()
            }
            .padding()
#if !os(watchOS)
            .background(colorScheme == .light ? .white : .secondaryBackground)
#endif
            .cornerRadius(15)
        }
    }
}

struct ClubInfoSection_Previews: PreviewProvider {
    static var previews: some View {
        ClubInfoSection(clubData: ClubData())
    }
}
