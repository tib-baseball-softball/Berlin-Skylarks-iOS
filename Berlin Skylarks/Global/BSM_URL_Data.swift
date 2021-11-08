//
//  BSM_URL_Data.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 03.11.21.
//

import Foundation
import SwiftUI

//-------------------------------SCORES------------------------------------//

//BSM API URLS to get the games //////
//those are hardcoded to the year 2021 - so I would need to push an update at least once a year, but there might also be a solution that works continually

//force unwrapping should not be an issue here - these are never nil

let urlPreviousGameday = URL(string: "https://bsm.baseball-softball.de/clubs/485/matches.json?filter[seasons][]=2021&search=skylarks&filters[gamedays][]=previous&api_key=IN__8yHVCeE3gP83Dvyqww")!
let urlCurrentGameday = URL(string: "https://bsm.baseball-softball.de/clubs/485/matches.json?filter[seasons][]=2021&search=skylarks&filters[gamedays][]=current&api_key=IN__8yHVCeE3gP83Dvyqww")!
let urlNextGameday = URL(string: "https://bsm.baseball-softball.de/clubs/485/matches.json?filter[seasons][]=2021&search=skylarks&filters[gamedays][]=next&api_key=IN__8yHVCeE3gP83Dvyqww")!
let urlFullSeason = URL(string: "https://bsm.baseball-softball.de/clubs/485/matches.json?filter[seasons][]=2021&search=skylarks&filters[gamedays][]=any&api_key=IN__8yHVCeE3gP83Dvyqww")!

//filtered by league

//https://bsm.baseball-softball.de/matches.json?filters[seasons][]=2021&filters[leagues][]=4801&filters[gamedays][]=previous

let scoresURLs = [
    "Previous": urlPreviousGameday,
    "Current": urlCurrentGameday,
    "Next": urlNextGameday,
    "Full Season": urlFullSeason,
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

let leagueTableURLs = [ urlVLBB, urlVLSB, urlLLBB, urlBZLBB, urlSchBB, urlTossBB ]

//-------------------------------DASHBOARD---------------------------------//

class UserDashboard: ObservableObject {
    @Published var displayDashboardLeagueTable = LeagueTable(league_id: 1, league_name: "Default League", season: Calendar.current.component(.year, from: Date()), rows: [])
    
    @Published var displayDashboardTableRow = LeagueTable.Row(rank: "X.", team_name: "Testteam", short_team_name: "XXX", match_count: 0, wins_count: 0, losses_count: 0, quota: ".000", games_behind: "0", streak: "00")
}

let dashboardTeamURLDict = [
    "Team 1 (VL)" : urlVLBB,
    "Softball (VL)" : urlVLSB,
    "Team 2 (LL)" : urlLLBB,
    "Team 3 (BZL)" : urlBZLBB,
    "Team 4 (BZL)" : urlBZLBB,
    "Jugend (U15)": urlSchBB, //placeholder
    "Schüler (U12)" : urlSchBB,
    "Tossball (U10)" : urlTossBB,
    "Teeball (U8)" : urlSchBB, //placeholder
]

//-------------------------------FUNKTIONÄRE---------------------------------//

//https://bsm.baseball-softball.de/clubs/485/club_functions.json
