//
//  BSM_URL_Data.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 03.11.21.
//

import Foundation
import SwiftUI

//changed IDs to 2022 season on 15-3-2022

var currentSeason = "2022" //Deprecated - using Int from AppStorage in future, but still needed for transition!
let skylarksID = "485" // this is probably never going to change - but most API calls work without it anyway

//-----------------------------change league IDs here--------------------------------//

//those IDs are not the LEAGUE IDs in BSM, they are the LEAGUEGROUP IDs (slightly different)
//MARK: Deprecated - process is dynamic now

//let idVLBB = "5137"
//let idVLSB = "5150"
//let idLLBB = "5138"
//let idBZLBB = "5145"
//let idJugBB = "5147"
//let idSchBB = "5148"
//let idTossBB = "4807" //not applicable for 2022
//let idTeeBB = "5149"

//-----------------------------empty Struct data--------------------------------//

let emptyTable = LeagueTable(league_id: 1, league_name: "League", season: Calendar.current.component(.year, from: Date()), rows: [])

let emptyRow = LeagueTable.Row(rank: " ", team_name: " ", short_team_name: " ", match_count: 0, wins_count: 0, losses_count: 0, quota: " ", games_behind: " ", streak: " ")

let emptyScoreTeam = GameScore.Team(name: "Team Name", short_name: "ACR", clubs: [])

let homeEntry = GameScore.LeagueEntry(team: emptyScoreTeam)
let awayEntry = GameScore.LeagueEntry(team: emptyScoreTeam)

let testGame = GameScore(id: 999, match_id: "111", time: "2020-08-08 17:00:00 +0200", league_id: 1, home_runs: 0, away_runs: 0, home_team_name: "Home", away_team_name: "Road", human_state: "getestet", scoresheet_url: nil, field: nil, league: emptyLeague, home_league_entry: homeEntry, away_league_entry: awayEntry, umpire_assignments: [], scorer_assignments: [], gameDate: .now)

//&sorted[time]=asc/desc

//https://bsm.baseball-softball.de/clubs/485/team_clubs.json?filters[seasons][]=2021&api_key=
//=> this yields all officially registered teams

//-------------------------------FUNKTIONÄRE---------------------------------//

//https://bsm.baseball-softball.de/clubs/485/club_functions.json
