//
//  BSMLeagueGroup.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 25.01.22.
//

import Foundation

/// BSM structure "Liga/Gruppe"
///
/// always unique to single season
/// caution: several `LeagueGroups` might have the same `League`
struct LeagueGroup: Hashable, Codable, Identifiable {
    var id: Int
    var season: Int
    var name: String
    var acronym: String
    var league: League
}

/// BSM structure "Liga", corresponds to a playing level
///
/// unique for each season
struct League: Hashable, Codable, Identifiable {
    var id: Int
    var season: Int
    var name: String
    var acronym: String
    var sport: String
    var classification: String
    var age_group: String?
}

let LEAGUEGROUP_ALL = LeagueGroup(id: 0, season: 0, name: "All Leagues", acronym: "ALL", league: emptyLeague)
let emptyLeague = League(id: 42, season: 1970, name: "Kreisliga", acronym: "TLL", sport: "Baseball", classification: "Kreisliga", age_group: "Erwachsene")
