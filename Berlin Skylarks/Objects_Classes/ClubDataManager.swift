//
//  ClubDataManager.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 19.07.22.
//

import Foundation

class ClubData: ObservableObject {
    @Published var club = BSMClub(id: 485, name: "Berlin Skylarks", short_name: "Skylarks", acronym: "BEA", organization_id: 9, number: 1100, headquarter: "Clombiadamm", main_club: "TiB", chairman: "", registered_association: "", address_addon: "", street: "", postal_code: "", city: "", country: "", latitude: 0, longitude: 0, successes: "")
}
