//
//  BSMFunctionary.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 14.07.22.
//

import Foundation

struct BSMFunctionary: Hashable, Codable, Identifiable {
    var id: Int
    var category: String //set by BSM (Enum)
    var function: String //set by user (Freitext)
    var mail: String
    var person: Person
}

let previewFunctionary = BSMFunctionary(id: 2, category: "Vorstand/Abteilungsleitung", function: "Abteilungsleitung Baseball", mail: "mail@example.com", person: previewPerson)
