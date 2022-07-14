//
//  BSMLicense.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 14.07.22.
//

import Foundation

struct BSMLicense: Hashable, Codable, Identifiable {
    var id: Int
    var number: String
    var valid_until: String
    var expiryDate: Date? // added by method
    var category: String
    var level: String
    var sport_association: String
    var baseball: Bool
    var softball: Bool
    var person: Person
}
