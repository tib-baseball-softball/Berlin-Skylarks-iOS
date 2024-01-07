//
//  GlobalFunctions.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 19.10.21.
//

import Foundation
import EventKit
import SwiftUI

//sort of deprecated - the GameScore struct now has a addDates() method, but this is still used by the calendar export

func getDatefromBSMString(gamescore: GameScore) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "y-M-dd HH:mm:ss Z"
    
    return dateFormatter.date(from: gamescore.time)!
    //force unwrapping alert: gametime really should be a required field in BSM DB - let's see if there are crashes
    //gameDate = dateFormatter.date(from: gamescore.time)!
}

func processGameDates(gamescores: [GameScore]) -> (next: GameScore?, last: GameScore?) {
    // processing
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyyMMdd"
    
    //for testing purposes this can be set to some date in the season, normally it's just the current date
    let now = Date()
    //let now = formatter.date(from: "20210928") ?? Date.now // September 27th, 2021 UTC
    
    var nextGames = [GameScore]()
    var previousGames = [GameScore]()

    //add game dates to all games to allow for ordering | outsourced below
    var gameList = gamescores
    
    for (index, _) in gameList.enumerated() {
        gameList[index].addDates()
    }
    
    //collect nextGames and add to array
    for gamescore in gameList where gamescore.gameDate! > now {
        nextGames.append(gamescore)
    }
    
    //Add last games to separate array and set it to be displayed
    for gamescore in gameList where gamescore.gameDate! < now {
        previousGames.append(gamescore)
    }
    
    //case: there is both a last and next game (e.g. middle of the season)
    if nextGames != [] && previousGames != [] {
        return (nextGames.first!, previousGames.last!)
    }
    
    //case: there is a previous game and no next game (e.g. season over for selected team)
    if nextGames == [] && previousGames != [] {
        return (nil, previousGames.last!)
    }
    
    //case: there is a next game and no previous game (e.g. season has not yet started for selected team)
    if nextGames != [] && previousGames == [] {
        return (nextGames.first!, nil)
    }
    
    //case: there is no game at all (error loading data, problems with async?)
    else {
        print("nothing to return, gamescores is empty")
        return (nil, nil)
    }
}

func determineTableRow(team: BSMTeam, table: LeagueTable) -> LeagueTable.Row {
    var correctRow = emptyRow
    
    for row in table.rows where row.team_name.contains("Skylarks") {
        //we might have two teams for BZL, so the function needs to account for the correct one
        
        if team.name.contains("3") {
            if row.team_name == "Skylarks 3" {
                correctRow = row
            }
        } else if team.name.contains("4") {
            if row.team_name == "Skylarks 4" {
                correctRow = row
            }
        } else if !team.name.contains("3") && !team.name.contains("4") {
            correctRow = row
        }
    }
    return correctRow
}

//-------------------------------------------------------------------------------//
//-----------------------------------LOAD DATA-----------------------------------//
//-------------------------------------------------------------------------------//

//MARK: Generic load function that accepts any codable type

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
    
    //load all leagueGroups
    do {
       loadedLeagues = try await fetchBSMData(url: leagueGroupsURL, dataType: [LeagueGroup].self)
    } catch {
        print("Request failed with error: \(error)")
    }
    return loadedLeagues
}

func loadTableForTeam(team: BSMTeam, leagueGroups: [LeagueGroup]) async -> LeagueTable? {
    var correctTable = emptyTable
    
    for leagueGroup in leagueGroups where team.league_entries[0].league.name == leagueGroup.name {
        let url = URL(string: "https://bsm.baseball-softball.de/leagues/" + "\(leagueGroup.id)" + "/table.json")!
        
        do {
            let table = try await fetchBSMData(url: url, dataType: LeagueTable.self)
            
            correctTable = table
        } catch {
            print("Request failed with error: \(error)")
            return nil
        }
    }
    return correctTable
}
