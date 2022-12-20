//
//  BSMTeam.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.11.21.
//

import Foundation

//based on BSM API

struct BSMTeam: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var short_name: String
    var league_entries: [LeagueEntry]
    var current_player_list: PlayerList?
    
    struct PlayerList: Hashable, Codable {
        var player_list_url: String?
        var player_list_entries: [PlayerListEntry]
        
        struct PlayerListEntry: Hashable, Codable {
            var number: Int
            var name: String
        }
    }
    struct LeagueEntry: Hashable, Codable {
        var league: League
    }
}

let emptyTeam = BSMTeam(id: 999, name: "Team Name", short_name: "ACR", league_entries: [BSMTeam.LeagueEntry(league: emptyLeague)], current_player_list: BSMTeam.PlayerList(player_list_entries: []))
