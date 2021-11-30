//
//  PlayerModel.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 28.11.21.
//

import Foundation
import SwiftUI

//based on csv from TYPO3 backend

struct Player: Hashable, Codable {
    var uid: Int
    var firstname: String
    var lastname: String
    var teams: [String]
    var birthday: String //let's see if I can pass the date directly, but probably DateFormatter is the way to go
    var admission: String
    var number: String
    var position: [String] //maybe a substruct?
    var throwing: String
    var batting: String
    var image: String // needs to be linked to URL => Image does not conform to Codable!
    var scorer: String?
    var umpire: String?
    var coach: String?
}

let testPlayer = Player(
                        uid: 123,
                        firstname: "Max",
                        lastname: "Mustermann",
                        teams: ["Team 1"],
                        birthday: "01.02.1990",
                        admission: "Mai 2020",
                        number: "21",
                        position: ["Pitcher", "First Base"],
                        throwing: "Right",
                        batting: "Left",
                        image: "TestImage",
                        scorer: "C",
                        umpire: "B",
                        coach: "C"
                                    )
