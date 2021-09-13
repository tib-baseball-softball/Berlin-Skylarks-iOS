//
//  BSMStandingsTable.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 09.08.21.
//

import Foundation
import SwiftUI

struct LeagueTable: Hashable, Codable {
    //var id: Int
    var league_id: Int
    var league_name: String
    var season: Int
    var rows: [Row]
    
    struct Row: Hashable, Codable {
        var rank: String
        var team_name: String
        var short_team_name: String
        var match_count: Int //those might be optionals!
        var wins_count: Int
        var losses_count: Int
        var quota: String
        var games_behind: String
        var streak: String //I need to check the error that occurred when the Poor Pigs retreted from the league and had an Int instead of a string in the original JSON! => fixed it in my dummy data
        
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
