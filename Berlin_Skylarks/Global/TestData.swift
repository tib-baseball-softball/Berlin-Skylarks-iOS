//
//  BSM_URL_Data.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 03.11.21.
//

import Foundation
import SwiftUI

let emptyTable = LeagueTable(league_id: 1, league_name: "League", season: Calendar.current.component(.year, from: Date()), rows: [])

let emptyRow = LeagueTable.Row(rank: " ", team_name: " ", short_team_name: " ", match_count: 0, wins_count: 0, losses_count: 0, quota: " ", games_behind: " ", streak: " ")

let emptyScoreTeam = GameScore.Team(name: "Team Name", short_name: "ACR", clubs: [])

let homeEntry = GameScore.LeagueEntry(team: emptyScoreTeam)
let awayEntry = GameScore.LeagueEntry(team: emptyScoreTeam)

let testGame = GameScore(id: 999, match_id: "111", time: "2020-08-08 17:00:00 +0200", league_id: 1, home_runs: 2, away_runs: 1, home_team_name: "Home Team", away_team_name: "Road Team", planned_innings: 7, human_state: "getestet", scoresheet_url: nil, field: nil, league: emptyLeague, home_league_entry: homeEntry, away_league_entry: awayEntry, umpire_assignments: [], scorer_assignments: [], gameDate: .now)
