//
//  BSMField.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 19.07.22.
//

import Foundation
import CoreLocation
import SwiftUI


struct BSMField: Hashable, Codable, Identifiable {
    var id: Int
    var club_id: Int?
    var name: String
    var address_addon: String
    var description: String
    var street: String?
    var postal_code: String?
    var city: String?
    var latitude: Double?
    var longitude: Double?
    var spectator_total: Int?
    var spectator_seats: Int?
    var human_country: String?
    var photo_url: String?
}


struct Ballpark: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

//this is used to store the image with the field data in one place
//not actually needed rn because of AsyncImage, but relevant for the GameScore case if I ever decide to refactor
struct FieldObject: Identifiable, Equatable {
    let id = UUID()
    var field: BSMField
    var image: Image?
}

let previewField = BSMField(id: 1, club_id: 485, name: "Zentralstadion - Baseball", address_addon: "Ballpark - Feld 1", description: "Anfahrt mit dem Auto\n\n\n\nAuf der A100 Richtung Schöneberg/Tempelhof die Ausfahrt 'Tempelhofer Damm' nehmen und abbiegen Richtung 'Kreuzberg/Schöneberg'.\n\n\n\nNach ca. einem Kilometer am Platz der Luftbrücke rechts in den Columbiadamm abbiegen.\n\n\n\nNach ca. einem weiteren Kilometer geht links die Lilienthalstraße (dritte Querstraße links) ab. Direkt hinter dieser liegt auf der linken Seite das TiB-Sportgelände. Gegenüber befindet sich der Gail-S.-Halvorsen-Park.\n\n\nAnfahrt mit den öffentlichen Verkehrsmitteln\n\nMit der U7 bis Südstern fahren und die Lilienthalstraße Richtung Flughafen Tempelhof entlanglaufen. Kurz vor dem Columbiadamm erscheint dann auf der linken Seite das Sportgelände. Der Gail-S.-Halvorsen-Park liegt gegenüber.\nVom U Platz der Luftbrücke (U6), vom U Boddinstr. (U8) oder vom S Julius-Leber-Brücke (S1) mit dem Bus 104 fahren. Er hält genau vor dem TiB-Sportgelände, Haltestelle \"Friedhöfe Columbiadamm.\"", street: "Hauptstraße 12", postal_code: "12345", city: "Berlin", latitude: 20, longitude: 20, spectator_total: 100, spectator_seats: 50, human_country: "Deutschland", photo_url: "")
