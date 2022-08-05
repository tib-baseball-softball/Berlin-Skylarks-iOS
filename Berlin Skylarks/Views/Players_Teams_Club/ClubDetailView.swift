//
//  ClubDetailView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 19.07.22.
//

import SwiftUI

struct ClubDetailView: View {
    
    @ObservedObject var clubData: ClubData
    
    var body: some View {
        List {
            Section(header: Text("Team Basics")) {
                HStack {
                    Spacer()
                    skylarksPrimaryLogo
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 200)
                    Spacer()
                }
                //.listRowBackground(Color.clear)
                HStack {
                    Image(systemName: "heart.text.square")
                        .clubIconStyleRed()
                    Text(clubData.club.name)
                }
                HStack {
                    Image(systemName: "creditcard")
                        .clubIconStyleRed()
                    Text("\(clubData.club.acronym) / 0\(clubData.club.organization_id) \(clubData.club.number)")
                }
                HStack {
                    Image(systemName: "shield")
                        .clubIconStyleRed()
                    Text(clubData.club.main_club)
                }
            }
#if !os(watchOS)
            .listRowSeparatorTint(.skylarksSand)
#endif
            Section(header: Text("Legal info")) {
                HStack {
                    Image(systemName: "person")
                        .clubIconStyleDynamic()
                    Text(clubData.club.chairman)
                }
                HStack {
                    Image(systemName: "number")
                        .clubIconStyleDynamic()
                    Text(clubData.club.registered_association)
                }
                HStack {
                    Image(systemName: "building.columns")
                        .clubIconStyleDynamic()
                    Text(clubData.club.court)
                }
            }
#if !os(watchOS)
            .listRowSeparatorTint(.skylarksSand)
#endif
            Section(header: Text("Location")) {
                HStack {
                    Image(systemName: "building")
                        .clubIconStyleDynamic()
                    Text(clubData.club.address_addon)
                }
                HStack {
                    Image(systemName: "map")
                        .clubIconStyleDynamic()
                    Text("\(clubData.club.street), \(clubData.club.postal_code) \(clubData.club.city), \(clubData.club.country)")
                }
                MapViewWithPin(latitude: clubData.club.latitude, longitude: clubData.club.longitude, name: clubData.club.name)
            }
        }
        .navigationTitle("Detailed Info")
    }
}

struct ClubDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ClubDetailView(clubData: ClubData())
        //.preferredColorScheme(.dark)
    }
}
