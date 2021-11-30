//
//  SkylarksTeams.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.11.21.
//

import Foundation

let team1 = Team(
                 name: "Team 1",
                 leagueName: "Verbandsliga",
                 sport: "Baseball",
                 ageGroup: "Erwachsene",
                 leagueID: "4800",
                 scoresURL: URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=2021&search=skylarks&filters[leagues][]=4800&filters[gamedays][]=any&api_key=IN__8yHVCeE3gP83Dvyqww")!,
                 leagueTableURL: URL(string:"https://bsm.baseball-softball.de/leagues/4800/table.json")!,
                 homeURL: URL(string:"")!
                                            )
