//
//  HomeViewModel.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 27.04.22.
//

import Foundation

@MainActor
@Observable
class HomeViewModel {
    var homeDatasets: [HomeDataset] = []
    
    /// Loads all data to used in the Home View (Favorite Team Overview).
    ///
    /// - load Games for all LeagueGroups the team is currently playing in
    /// - enrich data with additional information
    /// - determine previous and next game
    func loadHomeData(team: BSMTeam, leagueGroups: [LeagueGroup], season: Int) async {
        //get the games, then process for next and last
        
        // determine the correct leagueGroup(s)
        // caution: different LeagueGroups might have the same associated League
        let filteredLeagueGroups = leagueGroups.filter { $0.league.id == team.league_entries.first?.league.id }
        
        for leagueGroup in filteredLeagueGroups {
            var dataset: HomeDataset = HomeDataset()
            var gameList: [GameScore] = []
            
            // -------TODO: API client
            let selectedHomeScoresURL = URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=" + "\(season)" + "&search=skylarks&filters[leagues][]=" + "\(leagueGroup.id)" + "&filters[gamedays][]=any&api_key=" + apiKey)!
            
            do {
                gameList = try await fetchBSMData(url: selectedHomeScoresURL, dataType: [GameScore].self)
            } catch {
                print("Fetching data for team \(team.name) and league \(leagueGroup.name) (season: \(season)) failed with error: \(error)")
            }
            // -------end API client
            
            for (index, _) in gameList.enumerated() {
                gameList[index].addDates()
                gameList[index].determineGameStatus()
            }
            
            let displayGames = processGameDates(gamescores: gameList)
            
            if let nextGame = displayGames.next {
                dataset.nextGame = nextGame
                dataset.showNextGame = true
            } else {
                dataset.showNextGame = false
            }
            
            if let lastGame = displayGames.last {
                dataset.lastGame = lastGame
                dataset.showLastGame = true
            } else {
                dataset.showLastGame = false
            }
            
            //get playoff games (if applicable) - kind of a hacky solution since there is no definite info in the data structure identifying a single game as a playoff game
            dataset.playoffGames = gameList.filter { $0.match_id.contains("PO")}
            if !dataset.playoffGames.isEmpty {
                dataset.playoffParticipation = true
                dataset.playoffSeries.getSeriesStatus(playoffSeriesGames: dataset.playoffGames)
            } else {
                dataset.playoffParticipation = false
            }
            
            await loadHomeTeamTable(team: team, leagueGroup: leagueGroup, dataset: &dataset)
            
            homeDatasets.append(dataset)
        }
    }
    
    func createStreakDataEntries(games: [GameScore], row: LeagueTable.Row) -> [StreakDataEntry] {
        var entries: [StreakDataEntry] = []
        var wins = 0
        
        for (index, game) in games.enumerated() where
        game.human_state != "geplant"
        && game.human_state != "ausgefallen"
        && (game.away_team_name == row.team_name || game.home_team_name == row.team_name)
        {
            let number = index + 1
            var won = false
            
            if let skylarksWonGame = game.skylarksWin {
                if skylarksWonGame {
                    wins += 1
                    won = true
                }
            }
            entries.append(StreakDataEntry(game: "\(number)", wonGame: won, winsCount: wins))
        }
        return entries
    }
    
    private func loadHomeTeamTable(team: BSMTeam, leagueGroup: LeagueGroup, dataset: inout HomeDataset) async {
        let table = await loadSingleTable(for: leagueGroup)
        let row = determineTableRow(team: team, table: table)
        
        dataset.leagueTable = table
        dataset.tableRow = row
    }
}
