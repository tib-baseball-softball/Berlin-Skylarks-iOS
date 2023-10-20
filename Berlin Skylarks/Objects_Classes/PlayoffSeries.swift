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
    
    func getSeriesStatus(playoffSeriesGames: [GameScore]) {
        
        seriesLength = playoffSeriesGames.count
        firstTeam.name = playoffSeriesGames[0].away_team_name
        secondTeam.name = playoffSeriesGames[0].home_team_name
        
        for gamescore in playoffSeriesGames where firstTeam.name == gamescore.home_team_name && gamescore.homeTeamWin == true || firstTeam.name == gamescore.away_team_name && gamescore.homeTeamWin == false {
            if gamescore.state == .played {
                firstTeam.wins += 1
            }
        }
        for gamescore in playoffSeriesGames where secondTeam.name == gamescore.home_team_name && gamescore.homeTeamWin == true || secondTeam.name == gamescore.away_team_name && gamescore.homeTeamWin == false {
            if gamescore.state == .played {
                secondTeam.wins += 1
            }
        }
        
        // series hasn't started yet, saves us the calculations below
        if firstTeam.wins == 0 && secondTeam.wins == 0 {
            return
        }
        
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
