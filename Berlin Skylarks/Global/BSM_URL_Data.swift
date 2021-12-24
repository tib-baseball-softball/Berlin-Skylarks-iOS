//
//  BSM_URL_Data.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 03.11.21.
//

import Foundation
import SwiftUI

//These values are used for all URLs. They need to be manually adjusted for the correct season at the moment.

let currentSeason = "2021"
let skylarksID = "485"

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

let urlPreviousGameday = URL(string: "https://bsm.baseball-softball.de/clubs/" + skylarksID + "/matches.json?filter[seasons][]=" + currentSeason + "&search=skylarks&filters[gamedays][]=previous&api_key=" + apiKey)!
let urlCurrentGameday = URL(string: "https://bsm.baseball-softball.de/clubs/" + skylarksID + "/matches.json?filter[seasons][]=" + currentSeason + "&search=skylarks&filters[gamedays][]=current&api_key=" + apiKey)!
let urlNextGameday = URL(string: "https://bsm.baseball-softball.de/clubs/" + skylarksID + "/matches.json?filter[seasons][]=" + currentSeason + "&search=skylarks&filters[gamedays][]=next&api_key=" + apiKey)!
let urlFullSeason = URL(string: "https://bsm.baseball-softball.de/clubs/" + skylarksID + "/matches.json?filter[seasons][]=" + currentSeason + "&search=skylarks&filters[gamedays][]=any&api_key=" + apiKey)!



let scoresURLs = [
    "Previous Gameday": urlPreviousGameday,
    "Current Gameday": urlCurrentGameday,
    "Next Gameday": urlNextGameday,
    "Full Season Gameday": urlFullSeason,
    "Verbandsliga BB": team1.scoresURL,
    "Verbandsliga SB": teamSoftball.scoresURL,
    "Landesliga BB": team2.scoresURL,
    "Bezirksliga BB": team3.scoresURL,
    "Schülerliga": teamSchueler.scoresURL,
    "Tossballliga": teamTossball.scoresURL,
]


//-------------------------------STANDINGS/TABLES---------------------------------//

//these need to be changed every year after the schedule is published - there is no option to collect all tables for Skylarks teams like I do with scores
//apparently they also do not need an API key

//URLs are set in SkylarksTeams now

let leagueTableURLs = [ team1.leagueTableURL,
                        teamSoftball.leagueTableURL,
                        team2.leagueTableURL,
                        team3.leagueTableURL,
                        teamSchueler.leagueTableURL,
                        teamTossball.leagueTableURL, ]

//-------------------------------DASHBOARD---------------------------------//

class UserDashboard: ObservableObject {
    @Published var leagueTable = LeagueTable(league_id: 1, league_name: "Default League", season: Calendar.current.component(.year, from: Date()), rows: [])
    
    @Published var tableRow = LeagueTable.Row(rank: "X.", team_name: "Testteam", short_team_name: "XXX", match_count: 0, wins_count: 0, losses_count: 0, quota: ".000", games_behind: "0", streak: "00")
    
    @Published var NextGame = GameScore(id: 999, match_id: "111", time: "2020-08-08 17:00:00 +0200", gameDate: nil, home_runs: 0, away_runs: 0, home_team_name: "Home", away_team_name: "Road", human_state: "getestet", scoresheet_url: nil, field: nil, league: GameScore.League(id: 999, season: 1970, name: "Latest league"), home_league_entry: GameScore.Home_League_Entry(team: GameScore.Team(name: "Long home name", short_name: "ACR")), away_league_entry: GameScore.Away_League_Entry(team: GameScore.Team(name: "Long away name", short_name: "ACR")), umpire_assignments: [], scorer_assignments: [])
    
    @Published var LastGame = GameScore(id: 999, match_id: "111", time: "2020-08-08 17:00:00 +0200", gameDate: nil, home_runs: 0, away_runs: 0, home_team_name: "Home", away_team_name: "Road", human_state: "getestet", scoresheet_url: nil, field: nil, league: GameScore.League(id: 999, season: 1970, name: "Latest league"), home_league_entry: homeEntry, away_league_entry: awayEntry, umpire_assignments: [], scorer_assignments: [])
}

let homeEntry = GameScore.Home_League_Entry(team: GameScore.Team(name: "long home name", short_name: "ACR"))
let awayEntry = GameScore.Away_League_Entry(team: GameScore.Team(name: "long home name", short_name: "ACR"))
//&sorted[time]=asc/desc

//https://bsm.baseball-softball.de/clubs/485/team_clubs.json?filters[seasons][]=2021&api_key=IN__8yHVCeE3gP83Dvyqww
//=> this yields all officially registered teams

//-------------------------------FUNKTIONÄRE---------------------------------//

//https://bsm.baseball-softball.de/clubs/485/club_functions.json
