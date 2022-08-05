//
//  BSMClub.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 14.07.22.
//

import Foundation

struct BSMClub: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var short_name: String
    var acronym: String
    var organization_id: Int
    var number: Int
    var headquarter: String
    var main_club: String
    var chairman: String
    var registered_association: String
    var court: String
    var address_addon: String
    var street: String
    var postal_code: String
    var city: String
    var country: String
    var latitude: Double
    var longitude: Double
    var successes: String
}

let previewClub = BSMClub(id: 42, name: "Berlin Wallpeckers", short_name: "Wallpeckers", acronym: "BPP", organization_id: 0, number: 4564, headquarter: "", main_club: "Example e.V.", chairman: "John Doe", registered_association: "Example e.V.", court: "OLG Berlin", address_addon: "Stadion XY", street: "Test Street", postal_code: "12345", city: "Berlin", country: "DE", latitude: 45.5, longitude: 21.0, successes: "Decisive victory in the fall of 1989")
