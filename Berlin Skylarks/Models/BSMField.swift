//
//  BSMField.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 19.07.22.
//

import Foundation
import CoreLocation


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
