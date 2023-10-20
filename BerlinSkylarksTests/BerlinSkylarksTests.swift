//
//  BerlinSkylarksTests.swift
//  BerlinSkylarksTests
//
//  Created by David Battefeld on 22.08.22.
//

import XCTest
@testable import Berlin_Skylarks

class BerlinSkylarksTests: XCTestCase {
    
    var sut: Berlin_SkylarksApp!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Berlin_SkylarksApp()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testGamescoreDetermineGameStatus() throws {
        //Given
        var gamescore = GameScore(id: 2, match_id: "56754", time: "2020-08-08 17:00:00 +0200", league_id: 8948, home_team_name: "Home", away_team_name: "Away", planned_innings: 7, human_state: "getestet", league: emptyLeague, home_league_entry: homeEntry, away_league_entry: awayEntry, umpire_assignments: [], scorer_assignments: [])
        
        //When
        gamescore.determineGameStatus()
        
        //Then
        XCTAssertNotNil(gamescore.isExternalGame)
        XCTAssertNotNil(gamescore.skylarksWin)
        XCTAssertNotNil(gamescore.isDerby)
        XCTAssertNotNil(gamescore.skylarksAreHomeTeam)
    }
    
    func testAddingDatesToGames() throws {
        //checks if the date converter works in principle
        
        //Given
        var gamescore = GameScore(id: 2, match_id: "56754", time: "2020-08-08 17:00:00 +0200", league_id: 8948, home_team_name: "Home", away_team_name: "Away", planned_innings: 7, human_state: "getestet", league: emptyLeague, home_league_entry: homeEntry, away_league_entry: awayEntry, umpire_assignments: [], scorer_assignments: [])
        
        //When
        gamescore.addDates()
        
        //Then
        XCTAssertNotNil(gamescore.gameDate)
    }
    
    /*
     * Playoff series has not yet started - all games do not have scores yet
     */
    func testPlayoffSeriesBeforeStart() throws {
        
        // Given
        let playoffSeries = PlayoffSeries()
        var gamescores: [GameScore] = [
            GameScore(
                id: 1,
                match_id: "GM1",
                time: "2023-10-20 19:00:00 +0200",
                league_id: 9876,
                home_team_name: "New York Yankees",
                away_team_name: "Boston Red Sox",
                planned_innings: 9,
                human_state: "planned",
                league: emptyLeague,
                home_league_entry: homeEntry,
                away_league_entry: awayEntry,
                umpire_assignments: [],
                scorer_assignments: []
            ),
            GameScore(
                id: 2,
                match_id: "GM2",
                time: "2023-10-21 18:30:00 +0200",
                league_id: 9876,
                home_team_name: "New York Yankees",
                away_team_name: "Boston Red Sox",
                planned_innings: 9,
                human_state: "planned",
                league: emptyLeague,
                home_league_entry: homeEntry,
                away_league_entry: awayEntry,
                umpire_assignments: [],
                scorer_assignments: []
            ),
            GameScore(
                id: 3,
                match_id: "GM3",
                time: "2023-10-23 17:45:00 +0200",
                league_id: 9876,
                home_team_name: "Boston Red Sox",
                away_team_name: "New York Yankees",
                planned_innings: 9,
                human_state: "planned",
                league: emptyLeague,
                home_league_entry: homeEntry,
                away_league_entry: awayEntry,
                umpire_assignments: [],
                scorer_assignments: []
            ),
            GameScore(
                id: 4,
                match_id: "GM4",
                time: "2023-10-24 18:15:00 +0200",
                league_id: 9876,
                home_team_name: "Boston Red Sox",
                away_team_name: "New York Yankees",
                planned_innings: 9,
                human_state: "planned",
                league: emptyLeague,
                home_league_entry: homeEntry,
                away_league_entry: awayEntry,
                umpire_assignments: [],
                scorer_assignments: []
            ),
            GameScore(
                id: 5,
                match_id: "GM5",
                time: "2023-10-26 19:30:00 +0200",
                league_id: 9876,
                home_team_name: "New York Yankees",
                away_team_name: "Boston Red Sox",
                planned_innings: 9,
                human_state: "planned",
                league: emptyLeague,
                home_league_entry: homeEntry,
                away_league_entry: awayEntry,
                umpire_assignments: [],
                scorer_assignments: []
            ),
            GameScore(
                id: 6,
                match_id: "GM6",
                time: "2023-10-27 18:45:00 +0200",
                league_id: 9876,
                home_team_name: "New York Yankees",
                away_team_name: "Boston Red Sox",
                planned_innings: 9,
                human_state: "planned",
                league: emptyLeague,
                home_league_entry: homeEntry,
                away_league_entry: awayEntry,
                umpire_assignments: [],
                scorer_assignments: []
            ),
            GameScore(
                id: 7,
                match_id: "GM7",
                time: "2023-10-29 19:15:00 +0200",
                league_id: 9876,
                home_team_name: "Boston Red Sox",
                away_team_name: "New York Yankees",
                planned_innings: 9,
                human_state: "planned",
                league: emptyLeague,
                home_league_entry: homeEntry,
                away_league_entry: awayEntry,
                umpire_assignments: [],
                scorer_assignments: []
            )
        ]

        
        //When
        for (index, _) in gamescores.enumerated() {
            gamescores[index].addDates()
            gamescores[index].determineGameStatus()
        }
        playoffSeries.getSeriesStatus(playoffSeriesGames: gamescores)
        
        //Then
        XCTAssertEqual(gamescores.count, playoffSeries.seriesLength)
        XCTAssertEqual(playoffSeries.status, PlayoffSeries.Status.tied)
        XCTAssertEqual(playoffSeries.leadingTeam.wins, 0)
        XCTAssertEqual(playoffSeries.trailingTeam.wins, 0)
        XCTAssertEqual(playoffSeries.firstTeam.name, "Boston Red Sox")
    }
    
    func testPlayOffSeriesOngoing() throws {
        let playoffSeries = PlayoffSeries()
        var ongoingPlayoffSeries: [GameScore] = [
            GameScore(
                id: 1,
                match_id: "GM1",
                time: "2023-10-20 19:00:00 +0200",
                league_id: 9876,
                home_runs: 5,
                away_runs: 4,
                home_team_name: "New York Yankees",
                away_team_name: "Boston Red Sox",
                planned_innings: 9,
                human_state: "completed",
                league: emptyLeague,
                home_league_entry: homeEntry,
                away_league_entry: awayEntry,
                umpire_assignments: [],
                scorer_assignments: []
            ),
            GameScore(
                id: 2,
                match_id: "GM2",
                time: "2023-10-21 18:30:00 +0200",
                league_id: 9876,
                home_runs: 3,
                away_runs: 2,
                home_team_name: "New York Yankees",
                away_team_name: "Boston Red Sox",
                planned_innings: 9,
                human_state: "completed",
                league: emptyLeague,
                home_league_entry: homeEntry,
                away_league_entry: awayEntry,
                umpire_assignments: [],
                scorer_assignments: []
            ),
            GameScore(
                id: 3,
                match_id: "GM3",
                time: "2023-10-23 17:45:00 +0200",
                league_id: 9876,
                home_runs: 7,
                away_runs: 3,
                home_team_name: "Boston Red Sox",
                away_team_name: "New York Yankees",
                planned_innings: 9,
                human_state: "completed",
                league: emptyLeague,
                home_league_entry: homeEntry,
                away_league_entry: awayEntry,
                umpire_assignments: [],
                scorer_assignments: []
            ),
            GameScore(
                id: 4,
                match_id: "GM4",
                time: "2023-10-24 18:15:00 +0200",
                league_id: 9876,
                home_team_name: "Boston Red Sox",
                away_team_name: "New York Yankees",
                planned_innings: 9,
                human_state: "in_progress",
                league: emptyLeague,
                home_league_entry: homeEntry,
                away_league_entry: awayEntry,
                umpire_assignments: [],
                scorer_assignments: []
            ),
            GameScore(
                id: 5,
                match_id: "GM5",
                time: "2023-10-26 19:30:00 +0200",
                league_id: 9876,
                home_team_name: "Boston Red Sox",
                away_team_name: "New York Yankees",
                planned_innings: 9,
                human_state: "in_progress",
                league: emptyLeague,
                home_league_entry: homeEntry,
                away_league_entry: awayEntry,
                umpire_assignments: [],
                scorer_assignments: []
            ),
            GameScore(
                id: 6,
                match_id: "GM6",
                time: "2023-10-27 18:45:00 +0200",
                league_id: 9876,
                home_team_name: "New York Yankees",
                away_team_name: "Boston Red Sox",
                planned_innings: 9,
                human_state: "scheduled",
                league: emptyLeague,
                home_league_entry: homeEntry,
                away_league_entry: awayEntry,
                umpire_assignments: [],
                scorer_assignments: []
            ),
            GameScore(
                id: 7,
                match_id: "GM7",
                time: "2023-10-29 19:15:00 +0200",
                league_id: 9876,
                home_team_name: "New York Yankees",
                away_team_name: "Boston Red Sox",
                planned_innings: 9,
                human_state: "scheduled",
                league: emptyLeague,
                home_league_entry: homeEntry,
                away_league_entry: awayEntry,
                umpire_assignments: [],
                scorer_assignments: []
            )
        ]

        //When
        for (index, _) in ongoingPlayoffSeries.enumerated() {
            ongoingPlayoffSeries[index].addDates()
            ongoingPlayoffSeries[index].determineGameStatus()
        }
        playoffSeries.getSeriesStatus(playoffSeriesGames: ongoingPlayoffSeries)
        
        //Then
        XCTAssertEqual(ongoingPlayoffSeries.count, playoffSeries.seriesLength)
        XCTAssertEqual(playoffSeries.leadingTeam.name, "New York Yankees")
        XCTAssertEqual(playoffSeries.leadingTeam.wins, 2)
        XCTAssertEqual(playoffSeries.trailingTeam.wins, 1)
        XCTAssertEqual(playoffSeries.status, PlayoffSeries.Status.leading)
    }
    
    func testPlayOffSeriesOngoingContinued() throws {
        let playoffSeries = PlayoffSeries()
        var ongoingPlayoffSeries: [GameScore] = [
            GameScore(
                id: 1,
                match_id: "GM1",
                time: "2023-10-20 19:00:00 +0200",
                league_id: 9876,
                home_runs: 5,
                away_runs: 4,
                home_team_name: "New York Yankees",
                away_team_name: "Boston Red Sox",
                planned_innings: 9,
                human_state: "completed",
                league: emptyLeague,
                home_league_entry: homeEntry,
                away_league_entry: awayEntry,
                umpire_assignments: [],
                scorer_assignments: []
            ),
            GameScore(
                id: 2,
                match_id: "GM2",
                time: "2023-10-21 18:30:00 +0200",
                league_id: 9876,
                home_runs: 3,
                away_runs: 2,
                home_team_name: "New York Yankees",
                away_team_name: "Boston Red Sox",
                planned_innings: 9,
                human_state: "completed",
                league: emptyLeague,
                home_league_entry: homeEntry,
                away_league_entry: awayEntry,
                umpire_assignments: [],
                scorer_assignments: []
            ),
            GameScore(
                id: 3,
                match_id: "GM3",
                time: "2023-10-23 17:45:00 +0200",
                league_id: 9876,
                home_runs: 7,
                away_runs: 3,
                home_team_name: "Boston Red Sox",
                away_team_name: "New York Yankees",
                planned_innings: 9,
                human_state: "completed",
                league: emptyLeague,
                home_league_entry: homeEntry,
                away_league_entry: awayEntry,
                umpire_assignments: [],
                scorer_assignments: []
            ),
            GameScore(
                id: 4,
                match_id: "GM4",
                time: "2023-10-31 20:00:00 +0200",
                league_id: 9876,
                home_runs: 6,
                away_runs: 2,
                home_team_name: "Boston Red Sox",
                away_team_name: "New York Yankees",
                planned_innings: 9,
                human_state: "completed",
                league: emptyLeague,
                home_league_entry: homeEntry,
                away_league_entry: awayEntry,
                umpire_assignments: [],
                scorer_assignments: []
            ),
            GameScore(
                id: 5,
                match_id: "GM5",
                time: "2023-11-02 19:15:00 +0200",
                league_id: 9876,
                home_runs: 4,
                away_runs: 5,
                home_team_name: "Boston Red Sox",
                away_team_name: "New York Yankees",
                planned_innings: 9,
                human_state: "completed",
                league: emptyLeague,
                home_league_entry: homeEntry,
                away_league_entry: awayEntry,
                umpire_assignments: [],
                scorer_assignments: []
            ),
            GameScore(
                id: 6,
                match_id: "GM6",
                time: "2023-11-03 18:30:00 +0200",
                league_id: 9876,
                home_runs: 2,
                away_runs: 3,
                home_team_name: "New York Yankees",
                away_team_name: "Boston Red Sox",
                planned_innings: 9,
                human_state: "completed",
                league: emptyLeague,
                home_league_entry: homeEntry,
                away_league_entry: awayEntry,
                umpire_assignments: [],
                scorer_assignments: []
            ),
            GameScore(
                id: 7,
                match_id: "GM7",
                time: "2023-10-29 19:15:00 +0200",
                league_id: 9876,
                home_team_name: "New York Yankees",
                away_team_name: "Boston Red Sox",
                planned_innings: 9,
                human_state: "scheduled",
                league: emptyLeague,
                home_league_entry: homeEntry,
                away_league_entry: awayEntry,
                umpire_assignments: [],
                scorer_assignments: []
            )
        ]

        //When
        for (index, _) in ongoingPlayoffSeries.enumerated() {
            ongoingPlayoffSeries[index].addDates()
            ongoingPlayoffSeries[index].determineGameStatus()
        }
        playoffSeries.getSeriesStatus(playoffSeriesGames: ongoingPlayoffSeries)
        
        //Then
        XCTAssertEqual(ongoingPlayoffSeries.count, playoffSeries.seriesLength)
        XCTAssertEqual(playoffSeries.firstTeam.wins, 3)
        XCTAssertEqual(playoffSeries.secondTeam.wins, 3)
        XCTAssertEqual(playoffSeries.status, PlayoffSeries.Status.tied)
    }
    
    func testPlayOffSeriesFinal() throws {
        let playoffSeries = PlayoffSeries()
        var finishedPlayoffSeries: [GameScore] = [
            GameScore(
                id: 1,
                match_id: "GM1",
                time: "2023-10-20 19:00:00 +0200",
                league_id: 9876,
                home_runs: 5,
                away_runs: 4,
                home_team_name: "New York Yankees",
                away_team_name: "Boston Red Sox",
                planned_innings: 9,
                human_state: "completed",
                league: emptyLeague,
                home_league_entry: homeEntry,
                away_league_entry: awayEntry,
                umpire_assignments: [],
                scorer_assignments: []
            ),
            GameScore(
                id: 2,
                match_id: "GM2",
                time: "2023-10-21 18:30:00 +0200",
                league_id: 9876,
                home_runs: 3,
                away_runs: 2,
                home_team_name: "New York Yankees",
                away_team_name: "Boston Red Sox",
                planned_innings: 9,
                human_state: "completed",
                league: emptyLeague,
                home_league_entry: homeEntry,
                away_league_entry: awayEntry,
                umpire_assignments: [],
                scorer_assignments: []
            ),
            GameScore(
                id: 3,
                match_id: "GM3",
                time: "2023-10-23 17:45:00 +0200",
                league_id: 9876,
                home_runs: 7,
                away_runs: 3,
                home_team_name: "Boston Red Sox",
                away_team_name: "New York Yankees",
                planned_innings: 9,
                human_state: "completed",
                league: emptyLeague,
                home_league_entry: homeEntry,
                away_league_entry: awayEntry,
                umpire_assignments: [],
                scorer_assignments: []
            ),
            GameScore(
                id: 4,
                match_id: "GM4",
                time: "2023-10-31 20:00:00 +0200",
                league_id: 9876,
                home_runs: 6,
                away_runs: 2,
                home_team_name: "Boston Red Sox",
                away_team_name: "New York Yankees",
                planned_innings: 9,
                human_state: "completed",
                league: emptyLeague,
                home_league_entry: homeEntry,
                away_league_entry: awayEntry,
                umpire_assignments: [],
                scorer_assignments: []
            ),
            GameScore(
                id: 5,
                match_id: "GM5",
                time: "2023-11-02 19:15:00 +0200",
                league_id: 9876,
                home_runs: 4,
                away_runs: 5,
                home_team_name: "Boston Red Sox",
                away_team_name: "New York Yankees",
                planned_innings: 9,
                human_state: "completed",
                league: emptyLeague,
                home_league_entry: homeEntry,
                away_league_entry: awayEntry,
                umpire_assignments: [],
                scorer_assignments: []
            ),
            GameScore(
                id: 6,
                match_id: "GM6",
                time: "2023-11-03 18:30:00 +0200",
                league_id: 9876,
                home_runs: 2,
                away_runs: 3,
                home_team_name: "New York Yankees",
                away_team_name: "Boston Red Sox",
                planned_innings: 9,
                human_state: "completed",
                league: emptyLeague,
                home_league_entry: homeEntry,
                away_league_entry: awayEntry,
                umpire_assignments: [],
                scorer_assignments: []
            ),
            GameScore(
                id: 7,
                match_id: "GM7",
                time: "2023-10-29 19:15:00 +0200",
                league_id: 9876,
                home_runs: 11,
                away_runs: 3,
                home_team_name: "New York Yankees",
                away_team_name: "Boston Red Sox",
                planned_innings: 9,
                human_state: "scheduled",
                league: emptyLeague,
                home_league_entry: homeEntry,
                away_league_entry: awayEntry,
                umpire_assignments: [],
                scorer_assignments: []
            )
        ]

        //When
        for (index, _) in finishedPlayoffSeries.enumerated() {
            finishedPlayoffSeries[index].addDates()
            finishedPlayoffSeries[index].determineGameStatus()
        }
        playoffSeries.getSeriesStatus(playoffSeriesGames: finishedPlayoffSeries)
        
        //Then
        XCTAssertEqual(finishedPlayoffSeries.count, playoffSeries.seriesLength)
        XCTAssertEqual(playoffSeries.leadingTeam.wins, 4)
        XCTAssertEqual(playoffSeries.trailingTeam.wins, 3)
        XCTAssertEqual(playoffSeries.status, PlayoffSeries.Status.won)
        XCTAssertEqual(playoffSeries.leadingTeam.name, "New York Yankees")
    }
}
