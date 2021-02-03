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
    var match_id: String
    var time: String // needs to be converted to something else
    var home_runs: Int? //those really should be Ints
    var away_runs: Int?
    var home_team_name: String
    var away_team_name: String
    var human_state: String
    var field: Field
    
    struct Field: Hashable, Codable {
        var name: String
        var city: String
        //var latitude: Double?
       // var longitude: Double?
    }
//    var league_name: String
    //those exist in BSM, but need to be mapped to home ballpark, also only in detail view
    
/*     private var field: Coordinates
     var locationCoordinate: CLLocationCoordinate2D {
      CLLocationCoordinate2D(
            latitude: field.latitude,
            longitude: field.longitude)
    }
*/
}

