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
    var expiryDate: Date? // added by method below
    var category: String
    var level: String
    var sport_association: String?
    var sleeve_number: Int?
    var baseball: Bool
    var softball: Bool
    var person: Person
    
    mutating func getExpiryDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y-M-dd"
        
        expiryDate = dateFormatter.date(from: valid_until)
    }
}

let previewPerson = Person(id: 1, first_name: "Max", last_name: "Mustermann", birth_date: "12-4-1997")
let previewLicense = BSMLicense(id: 1, number: "C-3457358-UMP-BB", valid_until: "13-5-2023", category: "Umpire", level: "B", sleeve_number: 24, baseball: true, softball: false, person: previewPerson)
