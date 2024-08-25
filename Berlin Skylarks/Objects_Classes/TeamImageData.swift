//
//  TeamImageData.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 27.04.22.
//

import Foundation
import SwiftUI

class TeamImageData {
    //these are deprecated for actual use, but it's nevertheless helpful to have some fallback images defined
    static var away_team_logo = Image("App_road_team_logo")
    static var home_team_logo = Image("App_home_team_logo")

    static let skylarksPrimaryLogo = Image("Rondell")
    static let skylarksSecondaryLogo = Image("Bird_whiteoutline")

    static let flamingosLogo = Image("Berlin_Flamingos_Logo_3D")
    static let sluggersLogo = Image("Sluggers_Logo")

    static let teamLogos = [
        "Skylarks": Image("Bird_whiteoutline"),
        "Roosters": Image("Roosters_Logo"),
        "Sluggers": Image("Sluggers_Logo"),
        "Eagles": Image("Mahlow-Eagles_Logo"),
        "Ravens": Image("ravens_logo"),
        "R´s": Image("ravens_logo"),
        "Porcupines": Image("potsdam_logo"),
        "Sliders": Image("Sliders_Rund_2021"),
        "Flamingos": Image("Berlin_Flamingos_Logo_3D"),
        "Challengers": Image("challengers_Logo"),
        "Rams": Image("Rams-Logo"),
        "Wizards": Image("Wizards_Logo"),
        "Poor Pigs": Image("Poorpigs_Logo"),
        "Dukes": Image("Dukes_Logo"),
        "Roadrunners": Image("Roadrunners_Logo"),
        "Dragons": Image("Dragons_Logo"),
        "Dockers": Image("dockers"),
        "Regents": Image("regents-logo"),
        "Alligators": Image("elmshorn"),
        "Knights": Image("knights"),
        "Stealers": Image("Hamburg_Stealers"),
        "Wild Farmers": Image("Dohren_Wild_Farmers"),
        "Seahawks": Image("kiel"),
        "89ers": Image("89ers"),
    ]
    
    static func fetchCorrectLogos(gamescore: GameScore) -> (road: Image, home: Image) {
        
        var road = away_team_logo
        var home = home_team_logo
        
        for (name, image) in teamLogos {
            if gamescore.away_team_name.contains(name) {
                road = image
            } else if gamescore.home_team_name.contains(name) {
                home = image
            }
        }
        return (road, home)
    }
}
