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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
