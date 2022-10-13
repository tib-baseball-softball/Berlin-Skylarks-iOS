//
//  UserDashboard.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 27.04.22.
//

import Foundation


//-------------------------------DASHBOARD---------------------------------//

@MainActor
class UserDashboard: ObservableObject {
    @Published var leagueTable = emptyTable
    
    @Published var tableRow = emptyRow
    
    @Published var homeGamescores: [GameScore] = []
    @Published var playoffGames: [GameScore] = []
    
    @Published var NextGame = testGame
    @Published var LastGame = testGame
    
    @Published var showNextGame = false
    @Published var showLastGame = false
    
    @Published var playoffParticipation = false
    
    func loadHomeGameData(team: BSMTeam, leagueGroups: [LeagueGroup], season: Int) async {
        
        //get the games, then process for next and last
        var selectedHomeScoresURL = URL(string: "https://www.tib-baseball.de")!
        
        //determine the correct leagueGroup
        for leagueGroup in leagueGroups where team.league_entries[0].league.name == leagueGroup.name {
            selectedHomeScoresURL = URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=" + "\(season)" + "&search=skylarks&filters[leagues][]=" + "\(leagueGroup.id)" + "&filters[gamedays][]=any&api_key=" + apiKey)!
        }
    
        //load data
        do {
            homeGamescores = try await fetchBSMData(url: selectedHomeScoresURL, dataType: [GameScore].self)
        } catch {
            print("Request failed with error: \(error)")
        }
        
        for (index, _) in homeGamescores.enumerated() {
            homeGamescores[index].addDates()
            homeGamescores[index].determineGameStatus()
        }
        
        //call func to check for next and last game
        let displayGames = processGameDates(gamescores: homeGamescores)
        
        if let nextGame = displayGames.next {
            NextGame = nextGame
            showNextGame = true
        } else {
            showNextGame = false
        }
        
        if let lastGame = displayGames.last {
            LastGame = lastGame
            showLastGame = true
        } else {
            showLastGame = false
        }
        
        //get playoff games (if applicable)
        playoffGames = homeGamescores.filter { $0.match_id.contains("PO")}
        if !playoffGames.isEmpty {
            playoffParticipation = true
        } else {
            playoffParticipation = false
        }
    }
}
