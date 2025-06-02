//
//  GlobalFunctions.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 19.10.21.
//

import Foundation
import EventKit
import SwiftUI

/// Determines the games following and immediately preceding the current date from a list of games.
///
/// - Parameters:
///   - gamescores: an array of ``GameScore`` objects
///
/// Returns an optional tuple of ``GameScore`` instances, depending on the state of the season.
///
/// TODO: make generic by accepting ``Date`` parameter.
func processGameDates(gamescores: [GameScore]) -> (next: GameScore?, last: GameScore?) {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyyMMdd"
    
    //for testing purposes this can be set to some date in the season, normally it's just the current date
    let now = Date()
    //let now = formatter.date(from: "20210928") ?? Date.now // September 27th, 2021 UTC
    
    //add game dates to all games to allow for ordering
    var gameList = gamescores
    for (index, _) in gameList.enumerated() {
        gameList[index].addDates()
    }
    
    let nextGame = gameList.first(where: { $0.gameDate ?? now > now })
    let previousGame = gameList.last(where: { $0.gameDate ?? now < now })
    
    return (nextGame, previousGame)
}

func determineTableRow(team: BSMTeam, table: LeagueTable) -> LeagueTable.Row {
    let filteredRows = table.rows.filter { $0.team_name == team.name }
    return filteredRows.first ?? emptyRow
}

//-------------------------------------------------------------------------------//
//-----------------------------------LOAD DATA-----------------------------------//
//-------------------------------------------------------------------------------//

/// Generic load function that accepts any codable type.
///
/// Should be refactored to be the base of an API client class.
func fetchBSMData<T: Codable>(url: URL, dataType: T.Type) async throws -> T {
    
    let (data, _) = try await URLSession.shared.data(from: url)
    
    let responseObj = try JSONDecoder().decode(T.self, from: data)
    return responseObj
}

func loadSkylarksTeams(season: Int) async throws -> [BSMTeam] {
    
    let teamURL = URL(string:"https://bsm.baseball-softball.de/clubs/485/teams.json?filters[seasons][]=" + "\(season)" + "&sort[league_sort]=asc&api_key=" + apiKey)!
    let teams = try await fetchBSMData(url: teamURL, dataType: [BSMTeam].self)
    return teams
}

func loadLeagueGroups(season: Int) async -> [LeagueGroup] {
    
    let leagueGroupsURL = URL(string:"https://bsm.baseball-softball.de/league_groups.json?filters[seasons][]=" + "\(season)" + "&api_key=" + apiKey)!
    var loadedLeagues = [LeagueGroup]()
    
    do {
        loadedLeagues = try await fetchBSMData(url: leagueGroupsURL, dataType: [LeagueGroup].self)
    } catch {
        print("Request failed with error: \(error)")
    }
    return loadedLeagues
}

func loadTablesForTeam(team: BSMTeam, leagueGroups: [LeagueGroup]) async -> [LeagueTable] {
    var ret: [LeagueTable] = []
    
    for leagueGroup in leagueGroups where team.league_entries.first?.league.id == leagueGroup.league.id {
        let url = URL(string: "https://bsm.baseball-softball.de/leagues/\(leagueGroup.id)/table.json")!
        
        do {
            let table = try await fetchBSMData(url: url, dataType: LeagueTable.self)
            
            ret.append(table)
        } catch {
            print("Request failed with error: \(error)")
            return []
        }
    }
    return ret
}
