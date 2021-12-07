//
//  BSM_URL_Data.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 03.11.21.
//

import Foundation
import SwiftUI

let currentSeason = "2021"

//-----------------------------change league IDs here--------------------------------//

let idVLBB = "4800"
let idVLSB = "4805"
let idLLBB = "4801"
let idBZLBB = "4802"
let idJugBB = "4804" //placeholder
let idSchBB = "4804"
let idTossBB = "4807"

//-------------------------------SCORES------------------------------------//

//BSM API URLS to get the games //////
//those are hardcoded to the year 2021 - so I would need to push an update at least once a year, but there might also be a solution that works continually

//force unwrapping should not be an issue here - these are never nil

//URLs used on BSM web frontend

let urlPreviousGameday = URL(string: "https://bsm.baseball-softball.de/clubs/485/matches.json?filter[seasons][]=2021&search=skylarks&filters[gamedays][]=previous&api_key=IN__8yHVCeE3gP83Dvyqww")!
let urlCurrentGameday = URL(string: "https://bsm.baseball-softball.de/clubs/485/matches.json?filter[seasons][]=2021&search=skylarks&filters[gamedays][]=current&api_key=IN__8yHVCeE3gP83Dvyqww")!
let urlNextGameday = URL(string: "https://bsm.baseball-softball.de/clubs/485/matches.json?filter[seasons][]=2021&search=skylarks&filters[gamedays][]=next&api_key=IN__8yHVCeE3gP83Dvyqww")!
let urlFullSeason = URL(string: "https://bsm.baseball-softball.de/clubs/485/matches.json?filter[seasons][]=2021&search=skylarks&filters[gamedays][]=any&api_key=IN__8yHVCeE3gP83Dvyqww")!

//URLs by league - to be moved

//let urlScoresVLBB = URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=2021&search=skylarks&filters[leagues][]=4800&filters[gamedays][]=any&api_key=IN__8yHVCeE3gP83Dvyqww")!
let urlScoresVLSB = URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=2021&search=skylarks&filters[leagues][]=4805&filters[gamedays][]=any&api_key=IN__8yHVCeE3gP83Dvyqww")!
let urlScoresLLBB = URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=2021&search=skylarks&filters[leagues][]=4801&filters[gamedays][]=any&api_key=IN__8yHVCeE3gP83Dvyqww")!
let urlScoresBZLBB = URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=2021&search=skylarks&filters[leagues][]=4802&filters[gamedays][]=any&api_key=IN__8yHVCeE3gP83Dvyqww")!
let urlScoresSchBB = URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=2021&search=skylarks&filters[leagues][]=4804&filters[gamedays][]=any&api_key=IN__8yHVCeE3gP83Dvyqww")!
let urlScoresTossBB = URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=2021&search=skylarks&filters[leagues][]=4807&filters[gamedays][]=any&api_key=IN__8yHVCeE3gP83Dvyqww")!


let scoresURLs = [
    "Previous Gameday": urlPreviousGameday,
    "Current Gameday": urlCurrentGameday,
    "Next Gameday": urlNextGameday,
    "Full Season Gameday": urlFullSeason,
    "Verbandsliga BB": team1.scoresURL,
    "Verbandsliga SB": urlScoresVLSB,
    "Landesliga BB": urlScoresLLBB,
    "Bezirksliga BB": urlScoresBZLBB,
    "Schülerliga": urlScoresSchBB,
    "Tossballliga": urlScoresTossBB,
]


//-------------------------------STANDINGS/TABLES---------------------------------//

//these need to be changed every year after the schedule is published - there is no option to collect all tables for Skylarks teams like I do with scores
//apparently they also do not need an API key

let urlVLBB = URL(string:"https://bsm.baseball-softball.de/leagues/4800/table.json")!
let urlVLSB = URL(string:"https://bsm.baseball-softball.de/leagues/4805/table.json")!
let urlLLBB = URL(string:"https://bsm.baseball-softball.de/leagues/4801/table.json")!
let urlBZLBB = URL(string:"https://bsm.baseball-softball.de/leagues/4802/table.json")!
let urlJugBB = URL(string:"https://bsm.baseball-softball.de/leagues/4804/table.json")!
let urlSchBB = URL(string:"https://bsm.baseball-softball.de/leagues/4804/table.json")!
let urlTossBB = URL(string:"https://bsm.baseball-softball.de/leagues/4807/table.json")!

let leagueTableURLs = [ urlVLBB,
                        urlVLSB,
                        urlLLBB,
                        urlBZLBB,
                        urlSchBB,
                        urlTossBB ]

//-------------------------------DASHBOARD---------------------------------//

class UserDashboard: ObservableObject {
    @Published var leagueTable = LeagueTable(league_id: 1, league_name: "Default League", season: Calendar.current.component(.year, from: Date()), rows: [])
    
    @Published var tableRow = LeagueTable.Row(rank: "X.", team_name: "Testteam", short_team_name: "XXX", match_count: 0, wins_count: 0, losses_count: 0, quota: ".000", games_behind: "0", streak: "00")
    
    @Published var NextGame = GameScore(id: 999, match_id: "000", time: "2020-08-08 17:00:00 +0200", home_runs: 0, away_runs: 0, home_team_name: "Home", away_team_name: "Road", human_state: "getestet", scoresheet_url: nil, field: nil, league: GameScore.League(id: 999, season: 1970, name: "Next league"), umpire_assignments: [], scorer_assignments: [])
    
    @Published var LastGame = GameScore(id: 999, match_id: "111", time: "2020-08-08 17:00:00 +0200", home_runs: 0, away_runs: 0, home_team_name: "Home", away_team_name: "Road", human_state: "getestet", scoresheet_url: nil, field: nil, league: GameScore.League(id: 999, season: 1970, name: "Latest league"), umpire_assignments: [], scorer_assignments: [])
}

//let dashboardTeamURLDict = [
//    "Team 1 (VL)" : urlVLBB,
//    "Softball (VL)" : urlVLSB,
//    "Team 2 (LL)" : urlLLBB,
//    "Team 3 (BZL)" : urlBZLBB,
//    "Team 4 (BZL)" : urlBZLBB,
//    "Jugend (U15)": urlSchBB, //placeholder
//    "Schüler (U12)" : urlSchBB,
//    "Tossball (U10)" : urlTossBB,
//    "Teeball (U8)" : urlSchBB, //placeholder
//]

let urlHomeLLBB = URL(string:"dfgfd")!

//&sorted[time]=asc/desc

//https://bsm.baseball-softball.de/clubs/485/team_clubs.json?filters[seasons][]=2021&api_key=IN__8yHVCeE3gP83Dvyqww
//=> this yields all officially registered teams

//-------------------------------FUNKTIONÄRE---------------------------------//

//https://bsm.baseball-softball.de/clubs/485/club_functions.json
