//
//  BSM_URL_Data.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 03.11.21.
//

import Foundation
import SwiftUI

//These values are used for all URLs. They need to be manually adjusted for the correct season at the moment.

var currentSeason = "2021" //Deprecated - using Int from AppStorage now!
let skylarksID = "485" // this is probably never going to change indeed - but most API calls work without it anyway

//logos for easy usage

let skylarksPrimaryLogo = Image("Rondell")
let skylarksSecondaryLogo = Image("Bird_whiteoutline")

//-----------------------------change league IDs here--------------------------------//

//those IDs are not the LEAGUE IDs in BSM, they are the LEAGUEGROUP IDs (slightly different)
//MARK: WIP to make the whole process dynamic

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

//URLs used on BSM web frontend - now loaded locally in ScoresView

//let urlPreviousGameday = URL(string: "https://bsm.baseball-softball.de/clubs/" + skylarksID + "/matches.json?filter[seasons][]=" + currentSeason + "&search=skylarks&filters[gamedays][]=previous&api_key=" + apiKey)!
//let urlCurrentGameday = URL(string: "https://bsm.baseball-softball.de/clubs/" + skylarksID + "/matches.json?filter[seasons][]=" + currentSeason + "&search=skylarks&filters[gamedays][]=current&api_key=" + apiKey)!
//let urlNextGameday = URL(string: "https://bsm.baseball-softball.de/clubs/" + skylarksID + "/matches.json?filter[seasons][]=" + currentSeason + "&search=skylarks&filters[gamedays][]=next&api_key=" + apiKey)!
//let urlFullSeason = URL(string: "https://bsm.baseball-softball.de/clubs/" + skylarksID + "/matches.json?filter[seasons][]=" + currentSeason + "&search=skylarks&filters[gamedays][]=any&api_key=" + apiKey)!


//-------------------------------STANDINGS/TABLES---------------------------------//

//these need to be changed every year after the schedule is published - there is no option to collect all tables for Skylarks teams like I do with scores (WIP to find one)
//apparently they also do not need an API key (?)

//URLs are set in SkylarksTeams now

let leagueTableURLs = [ team1.leagueTableURL,
                        teamSoftball.leagueTableURL,
                        team2.leagueTableURL,
                        team3.leagueTableURL,
                        teamSchueler.leagueTableURL,
                        teamTossball.leagueTableURL, ]

//-------------------------------DASHBOARD---------------------------------//

class UserDashboard: ObservableObject {
    @Published var leagueTable = LeagueTable(league_id: 1, league_name: " ", season: Calendar.current.component(.year, from: Date()), rows: [])
    
    @Published var tableRow = LeagueTable.Row(rank: " ", team_name: " ", short_team_name: " ", match_count: 0, wins_count: 0, losses_count: 0, quota: " ", games_behind: " ", streak: " ")
    
    @Published var NextGame = testGame
    
    @Published var LastGame = testGame
}

let emptyScoreTeam = GameScore.Team(name: "Test Team", short_name: "ACR")

let homeEntry = GameScore.LeagueEntry(team: emptyScoreTeam)
let awayEntry = GameScore.LeagueEntry(team: emptyScoreTeam)

let testGame = GameScore(id: 999, match_id: "111", time: "2020-08-08 17:00:00 +0200", league_id: 1, home_runs: 0, away_runs: 0, home_team_name: "Home", away_team_name: "Road", human_state: "getestet", scoresheet_url: nil, field: nil, league: emptyLeague, home_league_entry: homeEntry, away_league_entry: awayEntry, umpire_assignments: [], scorer_assignments: [])

//&sorted[time]=asc/desc

//https://bsm.baseball-softball.de/clubs/485/team_clubs.json?filters[seasons][]=2021&api_key=
//=> this yields all officially registered teams

//-------------------------------FUNKTIONÄRE---------------------------------//

//https://bsm.baseball-softball.de/clubs/485/club_functions.json
