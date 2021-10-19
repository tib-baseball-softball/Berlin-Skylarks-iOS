//
//  GlobalScoresFunctions.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 19.10.21.
//

import Foundation

func determineGameStatus(gamescore: GameScore) {
    if gamescore.home_team_name.contains("Skylarks") && !gamescore.away_team_name.contains("Skylarks") {
        skylarksAreHomeTeam = true
        isDerby = false
    } else if gamescore.away_team_name.contains("Skylarks") && !gamescore.home_team_name.contains("Skylarks") {
        skylarksAreHomeTeam = false
        isDerby = false
    }
    if gamescore.away_team_name.contains("Skylarks") && gamescore.home_team_name.contains("Skylarks") {
        isDerby = true
    }
    if skylarksAreHomeTeam && !isDerby {
        if let awayScore = gamescore.away_runs, let homeScore = gamescore.home_runs {
            if homeScore > awayScore {
                skylarksWin = true
            }
            if homeScore < awayScore {
                skylarksWin = false
            }
        }
    } else if !skylarksAreHomeTeam && !isDerby {
        if let awayScore = gamescore.away_runs, let homeScore = gamescore.home_runs {
            if homeScore > awayScore {
                skylarksWin = false
            }
            if homeScore < awayScore {
                skylarksWin = true
            }
        }
    }
}

func setCorrectLogo(gamescore: GameScore) {
    for (name, image) in teamLogos {
        if gamescore.away_team_name.contains(name) {
            away_team_logo = image //teamLogos[name]
        }
    }
    
    for (name, image) in teamLogos {
        if gamescore.home_team_name.contains(name) {
            home_team_logo = image //teamLogos[name]
        }
    }
}

func getDatefromBSMString(gamescore: GameScore) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "y-M-dd HH:mm:ss Z"
    
    //force unwrapping alert: gametime really should be a required field in BSM DB - let's see if there are crashes
    gameDate = dateFormatter.date(from: gamescore.time)!
}
