//
//  BSMLeagueGroup.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 25.01.22.
//

import Foundation

//this class refers to what's known in BSM as Liga/Gruppe

struct LeagueGroup: Hashable, Codable, Identifiable {
    var id: Int
    var season: Int
    var name: String
    var acronym: String
    var league: League
}

struct League: Hashable, Codable, Identifiable {
    var id: Int
    var season: Int
    var name: String
    var acronym: String
    var sport: String
    var classification: String
    var age_group: String?
}

let emptyLeague = League(id: 42, season: 1970, name: "Test League", acronym: "TLL", sport: "Baseball", classification: "Kreisliga", age_group: "Erwachsene")
