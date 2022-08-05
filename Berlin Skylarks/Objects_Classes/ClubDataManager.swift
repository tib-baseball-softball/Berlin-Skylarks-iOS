//
//  ClubDataManager.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 19.07.22.
//

import Foundation

class ClubData: ObservableObject {
    @Published var club = BSMClub(id: 485, name: "Berlin Skylarks", short_name: "Skylarks", acronym: "BEA", organization_id: 9, number: 1100, headquarter: "Columbiadamm", main_club: "TiB", chairman: "Johannes Russ", registered_association: "VR xyz", court: "OLG Berlin", address_addon: "Geschäftsstelle", street: "Straße 12", postal_code: "12345", city: "Berlin", country: "DE", latitude: 0, longitude: 0, successes: "winning")
}
