//
//  BSMFunctionary.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 14.07.22.
//

import Foundation

struct BSMFunctionary: Hashable, Codable, Identifiable {
    var id: Int
    var function: String
    var mail: String
    var person: Person
}
