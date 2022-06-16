//
//  TeamImageData.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 27.04.22.
//

import Foundation
import SwiftUI

//these are deprecated for actual use, but it's nevertheless helpful to have some fallback images defined
var away_team_logo = Image("App_road_team_logo")
var home_team_logo = Image("App_home_team_logo")

let skylarksPrimaryLogo = Image("Rondell")
let skylarksSecondaryLogo = Image("Bird_whiteoutline")

let flamingosLogo = Image("Berlin_Flamingos_Logo_3D")
let sluggersLogo = Image("Sluggers_Logo")

let teamLogos = [
    "Skylarks": skylarksSecondaryLogo,
    "Roosters": Image("Roosters_Logo"),
    "Sluggers": sluggersLogo,
    "Eagles": Image("Mahlow-Eagles_Logo"),
    "Ravens": Image("ravens_logo"),
    "R´s": Image("ravens_logo"),
    "Porcupines": Image("potsdam_logo"),
    "Sliders": Image("Sliders_Rund_2021"),
    "Flamingos": flamingosLogo,
    "Challengers": Image("challengers_Logo"),
    "Rams": Image("Rams-Logo"),
    "Wizards": Image("Wizards_Logo"),
    "Poor Pigs": Image("Poorpigs_Logo"),
    "Dukes": Image("Dukes_Logo"),
    "Roadrunners": Image("Roadrunners_Logo"),
    "Dragons": Image("Dragons_Logo"),
]
