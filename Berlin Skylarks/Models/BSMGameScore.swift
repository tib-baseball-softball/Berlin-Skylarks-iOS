//
//  BSMGameScore.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 25.01.21.
//

import Foundation
import SwiftUI
import CoreLocation

//I am not sure if this works from the nested structure of the JSON (Apple one is flat)

struct GameScore: Hashable, Codable {
    var id: Int
    var match_id: String
    var time: String // needs to be converted to something else
    var home_runs: Int? //those really should be Ints
    var away_runs: Int?
    var home_team_name: String
    var away_team_name: String
//    var field_name: String //two entries in JSON
//    var field_city: String
//    var league_name: String
    
//    private var logoImageName: String
//    var teamLogo: Image {
//        Image(logoImageName)
//    }
    
    //those exist in BSM, but need to be mapped to home ballpark, also only in detail view
    
//    private var coordinates: Coordinates
//    var locationCoordinate: CLLocationCoordinate2D {
//        CLLocationCoordinate2D(
//            latitude: coordinates.latitude,
//            longitude: coordinates.longitude)
//    }

//    struct Coordinates: Hashable, Codable {
//       var latitude: Double
//       var longitude: Double
//    }
}
