//
//  TeamModel.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.11.21.
//

import Foundation

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
