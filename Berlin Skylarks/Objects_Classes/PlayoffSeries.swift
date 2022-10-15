//
//  PlayoffSeries.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 15.10.22.
//

import Foundation

class PlayoffSeries {
    enum Status {
        case leading, tied, won
    }
    
    var status = Status.tied
    var firstTeam = PlayoffTeam()
    var secondTeam = PlayoffTeam()
    var leadingTeam = PlayoffTeam()
    var trailingTeam = PlayoffTeam()
    
    var seriesLength = 0
    
    func getSeriesStatus(gamescores: [GameScore]) {
        
        seriesLength = gamescores.count
        firstTeam.name = gamescores[0].away_team_name
        secondTeam.name = gamescores[0].home_team_name
        
        for gamescore in gamescores where firstTeam.name == gamescore.home_team_name && gamescore.homeTeamWin == true || firstTeam.name == gamescore.away_team_name && gamescore.homeTeamWin == false {
            firstTeam.wins += 1
        }
        for gamescore in gamescores where secondTeam.name == gamescore.home_team_name && gamescore.homeTeamWin == true || secondTeam.name == gamescore.away_team_name && gamescore.homeTeamWin == false {
            secondTeam.wins += 1
        }
        
//        //DEBUG
//        print(firstTeam)
//        print(secondTeam)
        
        //seriesStatus
        if firstTeam.wins == secondTeam.wins {
            status = Status.tied
        } else if firstTeam.wins > seriesLength / 2 {
            status = Status.won
            leadingTeam = firstTeam
            trailingTeam = secondTeam
        } else if secondTeam.wins > seriesLength / 2 {
            status = Status.won
            leadingTeam = secondTeam
            trailingTeam = firstTeam
        } else if firstTeam.wins > secondTeam.wins && firstTeam.wins < seriesLength / 2 {
            status = Status.leading
            leadingTeam = firstTeam
            trailingTeam = secondTeam
        } else if secondTeam.wins > firstTeam.wins && secondTeam.wins < seriesLength / 2 {
            status = Status.leading
            leadingTeam = secondTeam
            trailingTeam = firstTeam
        }
    }
}

class PlayoffTeam {
    var name: String = "Team A"
    var wins: Int = 0
}
