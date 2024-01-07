//
//  MapViewWithPin.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 05.08.22.
//

import SwiftUI
import MapKit

struct MapViewWithPin: View {
    
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
    
    var latitude: Double
    var longitude: Double
    var name: String
    
    var body: some View {
        let fieldPin = [
            Ballpark(name: name, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)),
        ]
        let position = MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015)
            )
        )
        Map(initialPosition: position, interactionModes: []) {
            ForEach(fieldPin) { pin in
                Annotation(pin.name, coordinate: pin.coordinate) {
                    Image(systemName: "baseball")
                        .font(.headline)
                        .background(Color.skylarksRed)
                        .foregroundStyle(.white)
                        .clipShape(.circle)
                }
            }
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
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
}

struct MapViewWithPin_Previews: PreviewProvider {
    static var previews: some View {
        List {
            MapViewWithPin(latitude: 15, longitude: 35, name: "Important Location")
        }
    }
}
