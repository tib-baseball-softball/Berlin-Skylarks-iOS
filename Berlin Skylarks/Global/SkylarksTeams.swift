//
//  SkylarksTeams.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.11.21.
//

import Foundation

let testTeam = SkylarksTeam(
                 name: "Test Team",
                 leagueName: "Test League",
                 sport: "Baseball",
                 ageGroup: "Erwachsene",
                 scoresURL: URL(string: "https://www.tib-baseball.de")!,
                 leagueTableURL: URL(string:"https://www.tib-baseball.de")!,
                 homeURL: URL(string:"https://www.tib-baseball.de")!
                                            )

let team1 = SkylarksTeam(
                 name: "Team 1",
                 leagueName: "Verbandsliga",
                 sport: "Baseball",
                 ageGroup: "Erwachsene",
                 scoresURL: URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=" + currentSeason + "&search=skylarks&filters[leagues][]=" + idVLBB + "&filters[gamedays][]=any&api_key=" + apiKey)!,
                 leagueTableURL: URL(string:"https://bsm.baseball-softball.de/leagues/" + idVLBB + "/table.json")!,
                 homeURL: URL(string:"https://www.tib-baseball.de")!
                                            )

let team2 = SkylarksTeam(
                 name: "Team 2",
                 leagueName: "Landesliga",
                 sport: "Baseball",
                 ageGroup: "Erwachsene",
                 scoresURL: URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=" + currentSeason + "&search=skylarks&filters[leagues][]=" + idLLBB + "&filters[gamedays][]=any&api_key=" + apiKey)!,
                 leagueTableURL: URL(string:"https://bsm.baseball-softball.de/leagues/" + idLLBB + "/table.json")!,
                 homeURL: URL(string:"https://www.tib-baseball.de")!
                                            )

let team3 = SkylarksTeam(
                 name: "Team 3",
                 leagueName: "Bezirksliga",
                 sport: "Baseball",
                 ageGroup: "Erwachsene",
                 scoresURL: URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=" + currentSeason + "&search=skylarks&filters[leagues][]=" + idBZLBB + "&filters[gamedays][]=any&api_key=" + apiKey)!,
                 leagueTableURL: URL(string:"https://bsm.baseball-softball.de/leagues/" + idBZLBB + "/table.json")!,
                 homeURL: URL(string:"https://www.tib-baseball.de")!
                                            )

let team4 = SkylarksTeam(
                 name: "Team 4",
                 leagueName: "Bezirksliga",
                 sport: "Baseball",
                 ageGroup: "Erwachsene",
                 scoresURL: URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=" + currentSeason + "&search=skylarks&filters[leagues][]=" + idBZLBB + "&filters[gamedays][]=any&api_key=" + apiKey)!,
                 leagueTableURL: URL(string:"https://bsm.baseball-softball.de/leagues/" + idBZLBB + "/table.json")!,
                 homeURL: URL(string:"https://www.tib-baseball.de")!
                                            )

let teamSoftball = SkylarksTeam(
                 name: "Softball",
                 leagueName: "Verbandsliga",
                 sport: "Softball",
                 ageGroup: "Erwachsene",
                 scoresURL: URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=" + currentSeason + "&search=skylarks&filters[leagues][]=" + idVLSB + "&filters[gamedays][]=any&api_key=" + apiKey)!,
                 leagueTableURL: URL(string:"https://bsm.baseball-softball.de/leagues/" + idVLSB + "/table.json")!,
                 homeURL: URL(string:"https://www.tib-baseball.de")!
                                            )

let teamJugend = SkylarksTeam(
                 name: "Jugend",
                 leagueName: "Jugendliga",
                 sport: "Baseball",
                 ageGroup: "Nachwuchs",
                 scoresURL: URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=" + currentSeason + "&search=skylarks&filters[leagues][]=" + idJugBB + "&filters[gamedays][]=any&api_key=" + apiKey)!,
                 leagueTableURL: URL(string:"https://bsm.baseball-softball.de/leagues/" + idJugBB + "/table.json")!,
                 homeURL: URL(string:"https://www.tib-baseball.de")!
                                            )

let teamSchueler = SkylarksTeam(
                 name: "Schüler",
                 leagueName: "Schülerliga",
                 sport: "Baseball",
                 ageGroup: "Nachwuchs",
                 scoresURL: URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=" + currentSeason + "&search=skylarks&filters[leagues][]=" + idSchBB + "&filters[gamedays][]=any&api_key=" + apiKey)!,
                 leagueTableURL: URL(string:"https://bsm.baseball-softball.de/leagues/" + idSchBB + "/table.json")!,
                 homeURL: URL(string:"https://www.tib-baseball.de")!
                                            )

let teamTossball = SkylarksTeam(
                 name: "Tossball",
                 leagueName: "Tossballliga",
                 sport: "Baseball",
                 ageGroup: "Nachwuchs",
                 scoresURL: URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=" + currentSeason + "&search=skylarks&filters[leagues][]=" + idTossBB + "&filters[gamedays][]=any&api_key=" + apiKey)!,
                 leagueTableURL: URL(string:"https://bsm.baseball-softball.de/leagues/" + idTossBB + "/table.json")!,
                 homeURL: URL(string:"https://www.tib-baseball.de")!
                                            )

let allSkylarksTeams = [ team1, team2, team3, team4, teamSoftball, teamJugend, teamSchueler, teamTossball ]

//enum SkylarksTeams {
//    case team1
//    case team2
//    case team3
//    case team4
//    case teamSoftball
//    case teamJunioren
//    case teamJugend
//    case teamSchueler
//    case teamTossball
//    case teamTeeball
//}
