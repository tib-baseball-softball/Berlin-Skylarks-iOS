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
        var gamescore = GameScore(id: 2, match_id: "56754", time: "2020-08-08 17:00:00 +0200", league_id: 8948, home_team_name: "Home", away_team_name: "Away", human_state: "getestet", league: emptyLeague, home_league_entry: homeEntry, away_league_entry: awayEntry, umpire_assignments: [], scorer_assignments: [])
        
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
        var gamescore = GameScore(id: 2, match_id: "56754", time: "2020-08-08 17:00:00 +0200", league_id: 8948, home_team_name: "Home", away_team_name: "Away", human_state: "getestet", league: emptyLeague, home_league_entry: homeEntry, away_league_entry: awayEntry, umpire_assignments: [], scorer_assignments: [])
        
        //When
        gamescore.addDates()
        
        //Then
        XCTAssertNotNil(gamescore.gameDate)
    }
    
    func testPlayoffSeries() throws {
        
        // Given
        let playoffSeries = PlayoffSeries()
        var gamescores = [testGame, testGame, testGame, testGame, testGame, testGame, testGame]  //7 game series
        
        //When
        for (index, _) in gamescores.enumerated() {
            gamescores[index].addDates()
            gamescores[index].determineGameStatus()
        }
        playoffSeries.getSeriesStatus(gamescores: gamescores)
        
        //Then
        XCTAssertEqual(gamescores.count, playoffSeries.seriesLength)
        XCTAssertNotEqual(playoffSeries.leadingTeam, playoffSeries.trailingTeam)
        XCTAssertEqual(playoffSeries.status, PlayoffSeries.Status.won)
        XCTAssertEqual(playoffSeries.leadingTeam.wins, 7)
        XCTAssertEqual(playoffSeries.trailingTeam.wins, 0)
        XCTAssertNotEqual(playoffSeries.firstTeam.name, "Team A")
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
