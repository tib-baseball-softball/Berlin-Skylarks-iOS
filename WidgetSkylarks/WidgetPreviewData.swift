//
//  WidgetPreviewData.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 14.04.22.
//

import Foundation

let widgetPreviewLeague = League(id: 42, season: Calendar(identifier: .gregorian).dateComponents([.year], from: .now).year!, name: "Verbandsliga", acronym: "VLBB", sport: "Baseball", classification: "Verbandsliga", age_group: "Erwachsene")

let widgetPreviewRoadTeam = GameScore.Team(name: "Flamingos", short_name: "FLA", clubs: [])
let widgetPreviewNextOpponent = GameScore.Team(name: "Sluggers", short_name: "BES", clubs: [])
let widgetPreviewHomeTeam = GameScore.Team(name: "Skylarks", short_name: "BEA", clubs: [])

let widgetHomeEntry = GameScore.LeagueEntry(team: widgetPreviewHomeTeam)
let widgetAwayEntry = GameScore.LeagueEntry(team: widgetPreviewRoadTeam)
let widgetNextEntry = GameScore.LeagueEntry(team: widgetPreviewNextOpponent)

let widgetPreviewTeam = BSMTeam(id: 999, name: "Skylarks", short_name: "BEA", league_entries: [BSMTeam.LeagueEntry(league: widgetPreviewLeague)], current_player_list: BSMTeam.PlayerList(player_list_entries: []))

let widgetPreviewLastGame = GameScore(id: 999, match_id: "111", time: "2022-08-08 17:00:00 +0200", league_id: 1, home_runs: 10, away_runs: 2, home_team_name: "Skylarks", away_team_name: "Flamingos", planned_innings: 7, human_state: "gespielt", league: widgetPreviewLeague, home_league_entry: widgetHomeEntry, away_league_entry: widgetAwayEntry, umpire_assignments: [], scorer_assignments: [], gameDate: .now)

let widgetPreviewNextGame = GameScore(id: 999, match_id: "111", time: "2022-08-09 17:00:00 +0200", league_id: 1, home_runs: 7, away_runs: 1, home_team_name: "Skylarks", away_team_name: "Sluggers", planned_innings: 7, human_state: "gespielt", league: widgetPreviewLeague, home_league_entry: widgetHomeEntry, away_league_entry: widgetNextEntry, umpire_assignments: [], scorer_assignments: [], gameDate: .now)
