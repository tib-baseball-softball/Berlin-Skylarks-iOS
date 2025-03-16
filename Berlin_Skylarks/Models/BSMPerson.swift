//
//  BSMPerson.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 14.07.22.
//

import Foundation

struct Person: Hashable, Codable, Identifiable {
    var id: Int //this appears to be the OPASO number, too!
    var first_name: String
    var last_name: String
    var birth_date: String
    //there's more, but it's privacy-sensitive
}
