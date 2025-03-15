//
//  BallparkDetailView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 06.08.22.
//

import SwiftUI

struct BallparkDetailView: View {
    var fieldObject: FieldObject

    @Environment(\.verticalSizeClass) var verticalSizeClass

    var body: some View {
        List {
            Section {
                if let url = fieldObject.field.photo_url {
                    AsyncImage(url: URL(string: url)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            #if !os(macOS)
                                .frame(
                                    maxHeight: verticalSizeClass == .regular
                                        && UIDevice.current.userInterfaceIdiom
                                            != .phone
                                        ? 400 : 200)
                            #elseif os(macOS)
                                .frame(height: 400)
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
            .listRowInsets(
                EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))

            Section(header: Text("General Data")) {
                HStack {
                    Image(systemName: "diamond.fill")
                        .clubIconStyleRed()
                    Text(fieldObject.field.name)
                        .textSelection(.enabled)
                }
                HStack {
                    Image(systemName: "info.circle")
                        .foregroundColor(.secondary)
                        .clubIconStyleRed()
                    Text(fieldObject.field.address_addon)
                        .textSelection(.enabled)
                }
                .foregroundColor(.secondary)
                if let total = fieldObject.field.spectator_total,
                    let seats = fieldObject.field.spectator_seats
                {
                    HStack {
                        Image(systemName: "person.2.fill")
                            .clubIconStyleDynamic()
                        Text("Capacity: ") + Text(String(total))
                    }
                    HStack {
                        Image(systemName: "ticket.fill")
                            .clubIconStyleDynamic()
                        Text("Seats: ") + Text(String(seats))
                    }
                }
            }
            if let latitude = fieldObject.field.latitude,
                let longitude = fieldObject.field.longitude,
                let street = fieldObject.field.street,
                let postalCode = fieldObject.field.postal_code,
                let city = fieldObject.field.city
            {
                Section(
                    header: HStack {
                        Text("Location")
                        Image(systemName: "location")
                    }
                ) {
                    MapViewWithPin(
                        latitude: latitude, longitude: longitude,
                        name: fieldObject.field.name)
                    HStack {
                        Image(systemName: "map")
                            .clubIconStyleDynamic()
                        Text("\(street), \(postalCode) \(city)")
                            .textSelection(.enabled)
                    }
                }
            } else {
                //this should never happen since we can control whether we have an address set or not (BSM access)
                HStack {
                    Image(systemName: "map")
                        .clubIconStyleDynamic()
                    Text("No location data available.")
                }
            }
            Section(
                header: HStack {
                    Text("Directions")
                    Image(systemName: "car.fill")
                    Image(systemName: "bicycle")
                    Image(systemName: "tram.fill")
                    Image(systemName: "bus.fill")
                    Image(systemName: "figure.walk")
                }
            ) {
                Text(fieldObject.field.description)
                    .textSelection(.enabled)
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
