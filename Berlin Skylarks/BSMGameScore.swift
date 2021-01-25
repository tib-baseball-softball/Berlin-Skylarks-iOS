//
//  BSMGameScore.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 25.01.21.
//

import Foundation
import SwiftUI
import CoreLocation

struct GameScore: Hashable, Codable {
    var id: Int
    var match_id: Int
    var time: Int // needs something else
    var home_runs: Int
    var away_runs: Int
    var home_team_name: String
    var away_team_name: String
    var field_name: String //two entries in JSON
    var field_city: String
    var league_name: String
    
    private var logoImageName: String
    var teamLogo: Image {
        Image(logoImageName)
    }
    
    //those exist in BSM, but need to be mapped to home ballpark, also only in detail view
    
    private var coordinates: Coordinates
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }

    struct Coordinates: Hashable, Codable {
       var latitude: Double
       var longitude: Double
    }
}
