//
//  HomeDataset.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 04.06.25.
//

import Foundation

@Observable
class HomeDataset {
    var id = UUID()
    var leagueTable = emptyTable
    var tableRow = emptyRow
    
    var homeGamescores: [GameScore] = []
    var playoffGames: [GameScore] = []
    
    var playoffSeries = PlayoffSeries()
    
    var nextGame = testGame
    var lastGame = testGame
    
    var showNextGame = false
    var showLastGame = false
    
    var playoffParticipation = false
}
