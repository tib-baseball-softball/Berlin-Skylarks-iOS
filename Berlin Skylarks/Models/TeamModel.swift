//
//  TeamModel.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.11.21.
//

import Foundation

//based on nothing

struct SkylarksTeam: Hashable, Codable {
    var name: String
    var leagueName: String
    var sport: String
    var ageGroup: String?
    //var leagueID: String
    var scoresURL: URL
    var leagueTableURL: URL
    var homeURL: URL
    
}

//based on BSM API

struct BSMTeam: Hashable, Codable, Identifiable {
    var id: Int?
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

let emptyTeam = BSMTeam(id: 999, name: "Test Team", short_name: "ACR", league_entries: [BSMTeam.LeagueEntry(league: emptyLeague)], current_player_list: BSMTeam.PlayerList(player_list_entries: []))

//this crashes at runtime

//extension Team: RawRepresentable {
//    public init?(rawValue: String) {
//        guard let data = rawValue.data(using: .utf8),
//            let result = try? JSONDecoder().decode(Team.self, from: data)
//        else {
//            return nil
//        }
//        self = result
//    }
//
//    public var rawValue: String {
//        guard let data = try? JSONEncoder().encode(self),
//            let result = String(data: data, encoding: .utf8)
//        else {
//            return "[]"
//        }
//        return result
//    }
//}
