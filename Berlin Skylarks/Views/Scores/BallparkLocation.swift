//
//  BallparkLocation.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 06.06.22.
//

import SwiftUI
import MapKit

struct BallparkLocation: View {
    
#if !os(watchOS)
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    //computed property to use a bigger map on larger screens, but not on portrait iPhones
    private var expandMap: Bool {
        if verticalSizeClass == .regular && UIDevice.current.userInterfaceIdiom != .phone {
            return true
        }
        return false
    }
#endif
    var gamescore: GameScore
    
    var body: some View {
        if let field = gamescore.field {
            if let coordinateLatitude = field.latitude, let coordinateLongitude = field.longitude {
                if coordinateLatitude == 0 && coordinateLongitude == 0 {
                    HStack {
                        Image(systemName: "mappin.slash.circle.fill")
                            .foregroundColor(.skylarksRed)
                        Text("No map data provided")
                    }
                    .padding(ScoresItemPadding)
                } else {
                    let fieldPin = [
                        Ballpark(name: field.name, coordinate: CLLocationCoordinate2D(latitude: coordinateLatitude, longitude: coordinateLongitude)),
                    ]
                    Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: coordinateLatitude, longitude: coordinateLongitude), span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015))), interactionModes: [], annotationItems: fieldPin) {
                        MapMarker(coordinate: $0.coordinate, tint: Color.accentColor)
                    }
                    #if !os(watchOS)
                    .frame(height: expandMap ? 500 : 200)
                    #else
                    .frame(height: 200)
                    #endif
                    
                    .onTapGesture(perform: {
                        if !fieldPin.isEmpty {
                            let coordinate = fieldPin[0].coordinate
                            let placemark = MKPlacemark(coordinate: coordinate)
                            let mapItem = MKMapItem(placemark: placemark)
                            mapItem.name = fieldPin[0].name
                            mapItem.openInMaps()
                        }
                    })
                }
                
            } else {
                // this never gets fired because it appears that empty coordinates are 0 instead of nil
                HStack {
                    Image(systemName: "mappin.slash.circle.fill")
                        .foregroundColor(.skylarksRed)
                    Text("No field coordinates provided")
                }
                .padding(ScoresItemPadding)
            }
            HStack {
                Image(systemName: "diamond.fill") //this really needs a custom icon
                Text(String(field.name))
            }
            .padding(ScoresItemPadding)
            HStack {
                Image(systemName: "map")
                if let street = field.street, let postalCode = field.postal_code, let city = field.city {
                    Text("\(street), \(postalCode) \(city)")
                } else {
                    Text("No address data provided")
                }
            }
            .padding(ScoresItemPadding)
        } else {
            HStack {
                Image(systemName: "diamond.fill")
                Text("No location/field data")
            }
        }
    }
}

struct BallparkLocation_Previews: PreviewProvider {
    static var previews: some View {
        List {
            BallparkLocation(gamescore: testGame)
        }
    }
}
