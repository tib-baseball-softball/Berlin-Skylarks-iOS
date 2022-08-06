//
//  BallparkDetailView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 06.08.22.
//

import SwiftUI

struct BallparkDetailView: View {
    var fieldObject: FieldObject
    
#if !os(watchOS)
    @Environment(\.verticalSizeClass) var verticalSizeClass
#endif
    
    var body: some View {
        List {
            Section {
                if let url = fieldObject.field.photo_url {
                    AsyncImage(url: URL(string: url)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                        #if !os(watchOS)
                            .frame(maxHeight: verticalSizeClass == .regular && UIDevice.current.userInterfaceIdiom != .phone ? 400 : 200)
                        #else
                            .frame(maxHeight: 100)
                        #endif
                    } placeholder: {
                        HStack {
                            Spacer()
                            ProgressView("Image is loading...")
                                .padding()
                            Spacer()
                        }
                    }
                }
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            Section(header: Text("General Data")) {
                HStack {
                    Image(systemName: "diamond.fill")
                        .clubIconStyleRed()
                    Text(fieldObject.field.name)
#if !os(watchOS)
                    .textSelection(.enabled)
#endif
                }
                HStack {
                    Image(systemName: "info.circle")
                        .foregroundColor(.secondary)
                        .clubIconStyleRed()
                    Text(fieldObject.field.address_addon)
#if !os(watchOS)
                    .textSelection(.enabled)
#endif
                }
                .foregroundColor(.secondary)
                if let total = fieldObject.field.spectator_total, let seats = fieldObject.field.spectator_seats {
                    HStack {
                        Image(systemName: "person.2.fill")
                            .clubIconStyleDynamic()
                        Text("Capacity: \(total)")
                    }
                    HStack {
                        Image(systemName: "ticket.fill")
                            .clubIconStyleDynamic()
                        Text("Seats: \(seats)")
                    }
                }
                
            }
            Section(header: HStack {
                Text("Directions")
                Image(systemName: "car.fill")
                Image(systemName: "bicycle")
                Image(systemName: "tram.fill")
                Image(systemName: "bus.fill")
                Image(systemName: "figure.walk")
            }) {
                Text(fieldObject.field.description)
#if !os(watchOS)
                    .textSelection(.enabled)
#endif
            }
        }
        .navigationTitle("Ballpark Detail")
    }
}

struct BallparkDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BallparkDetailView(fieldObject: FieldObject(field: previewField))
        }
    }
}
