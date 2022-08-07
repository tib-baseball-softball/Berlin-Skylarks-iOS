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
#if !os(watchOS)
                        .frame(maxWidth: 200)
#else
                        .frame(maxWidth: 100)
#endif
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
#if !os(watchOS)
                        .textSelection(.enabled)
#endif
                }
            }
#if !os(watchOS)
            .listRowSeparatorTint(.skylarksSand)
#endif
            Section {
                HStack {
                    Image(systemName: "flag.2.crossed.fill")
                        .clubIconStyleRed()
                    Text("Achievements")
                        .font(.headline)
                        .padding(5)
                }
                Text(clubData.club.successes)
            }
            
            Section(header: Text("Legal info")) {
                HStack {
                    Image(systemName: "person")
                        .clubIconStyleDynamic()
                    Text(clubData.club.chairman)
#if !os(watchOS)
                        .textSelection(.enabled)
#endif
                }
                HStack {
                    Image(systemName: "number")
                        .clubIconStyleDynamic()
                    Text(clubData.club.registered_association)
#if !os(watchOS)
                        .textSelection(.enabled)
#endif
                }
                HStack {
                    Image(systemName: "building.columns")
                        .clubIconStyleDynamic()
                    Text(clubData.club.court)
#if !os(watchOS)
                        .textSelection(.enabled)
#endif
                }
            }
#if !os(watchOS)
            .listRowSeparatorTint(.skylarksSand)
#endif
            Section(header: HStack {
                        Text("Location")
                        Image(systemName: "location")
            }){
                HStack {
                    Image(systemName: "building")
                        .clubIconStyleDynamic()
                    Text(clubData.club.address_addon)
                }
                HStack {
                    Image(systemName: "map")
                        .clubIconStyleDynamic()
                    Text("\(clubData.club.street), \(clubData.club.postal_code) \(clubData.club.city), \(clubData.club.country)")
#if !os(watchOS)
                        .textSelection(.enabled)
#endif
                }
                MapViewWithPin(latitude: clubData.club.latitude, longitude: clubData.club.longitude, name: clubData.club.name)
            }
#if !os(watchOS)
            .listRowSeparatorTint(.skylarksSand)
#endif
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
