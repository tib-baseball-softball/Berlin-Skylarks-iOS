//
//  BSMStandingsTable.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 09.08.21.
//

import Foundation
import SwiftUI

struct LeagueTable: Hashable, Codable, Identifiable {
    var id: Int
    var league_id: String
    var league_name: String
    var season: Int
    var rows: [Rows]
    
    struct Rows: Hashable, Codable {
        var rank: String
        var team_name: String
        var short_team_name: String
        var match_count: Int //those might be optionals!
        var wins_count: Int
        var losses_count: Int
        var quota: String
        var games_behind: String
        var streak: String
        
//        var league_entry: LeagueEntry
//    }
//
//    struct LeagueEntry: Hashable, Codable {
//        var id: Int
//        var team: Team
//    }
//
//    struct Team: Hashable, Codable {
//        var name: String
//        var short_name: String
    }
}
