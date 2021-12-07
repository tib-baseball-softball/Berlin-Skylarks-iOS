//
//  SkylarksTeams.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.11.21.
//

import Foundation

let testTeam = Team(
                 name: "Test Team",
                 leagueName: "Test League",
                 sport: "Baseball",
                 ageGroup: "Erwachsene",
                 scoresURL: URL(string: "https://www.tib-baseball.de")!,
                 leagueTableURL: URL(string:"https://www.tib-baseball.de")!,
                 homeURL: URL(string:"https://www.tib-baseball.de")!
                                            )

let team1 = Team(
                 name: "Team 1",
                 leagueName: "Verbandsliga",
                 sport: "Baseball",
                 ageGroup: "Erwachsene",
                 scoresURL: URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=2021&search=skylarks&filters[leagues][]=" + idVLBB + "&filters[gamedays][]=any&api_key=" + apiKey)!,
                 leagueTableURL: URL(string:"https://bsm.baseball-softball.de/leagues/4800/table.json")!,
                 homeURL: URL(string:"https://www.tib-baseball.de")!
                                            )

let team2 = Team(
                 name: "Team 2",
                 leagueName: "Landesliga",
                 sport: "Baseball",
                 ageGroup: "Erwachsene",
                 scoresURL: URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=2021&search=skylarks&filters[leagues][]=4801&filters[gamedays][]=any&api_key=IN__8yHVCeE3gP83Dvyqww")!,
                 leagueTableURL: URL(string:"https://bsm.baseball-softball.de/leagues/4801/table.json")!,
                 homeURL: URL(string:"https://www.tib-baseball.de")!
                                            )

let team3 = Team(
                 name: "Team 3",
                 leagueName: "Bezirksliga",
                 sport: "Baseball",
                 ageGroup: "Erwachsene",
                 scoresURL: URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=2021&search=skylarks&filters[leagues][]=4802&filters[gamedays][]=any&api_key=IN__8yHVCeE3gP83Dvyqww")!,
                 leagueTableURL: URL(string:"https://bsm.baseball-softball.de/leagues/4802/table.json")!,
                 homeURL: URL(string:"https://www.tib-baseball.de")!
                                            )

let team4 = Team(
                 name: "Team 4",
                 leagueName: "Bezirksliga",
                 sport: "Baseball",
                 ageGroup: "Erwachsene",
                 scoresURL: URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=2021&search=skylarks&filters[leagues][]=4802&filters[gamedays][]=any&api_key=IN__8yHVCeE3gP83Dvyqww")!,
                 leagueTableURL: URL(string:"https://bsm.baseball-softball.de/leagues/4802/table.json")!,
                 homeURL: URL(string:"https://www.tib-baseball.de")!
                                            )

let teamSoftball = Team(
                 name: "Softball",
                 leagueName: "Verbandsliga",
                 sport: "Softball",
                 ageGroup: "Erwachsene",
                 scoresURL: URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=2021&search=skylarks&filters[leagues][]=4805&filters[gamedays][]=any&api_key=IN__8yHVCeE3gP83Dvyqww")!,
                 leagueTableURL: URL(string:"https://bsm.baseball-softball.de/leagues/4805/table.json")!,
                 homeURL: URL(string:"https://www.tib-baseball.de")!
                                            )

let teamJugend = Team(
                 name: "Jugend",
                 leagueName: "Jugendliga",
                 sport: "Baseball",
                 ageGroup: "Nachwuchs",
                 scoresURL: URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=2021&search=skylarks&filters[leagues][]=4803&filters[gamedays][]=any&api_key=IN__8yHVCeE3gP83Dvyqww")!,
                 leagueTableURL: URL(string:"https://bsm.baseball-softball.de/leagues/4803/table.json")!,
                 homeURL: URL(string:"https://www.tib-baseball.de")!
                                            )

let allSkylarksTeams = [ team1, team2 ]
