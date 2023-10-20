//
//  File.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 20.10.23.
//

import Foundation

class PlayoffTeam: Equatable {
    var name: String = "Team A"
    var wins: Int = 0
    
    static func == (lhs: PlayoffTeam, rhs: PlayoffTeam) -> Bool {
        return lhs.name == rhs.name && lhs.wins == rhs.wins
    }
}
