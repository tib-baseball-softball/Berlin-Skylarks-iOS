//
//  BSMGameScore.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 25.01.21.
//

import Foundation
import SwiftUI
import CoreLocation

//not sure if this actually conforms to Identifiable! --> added in tutorial

struct GameScore: Hashable, Codable, Identifiable {
    var id: Int
    var match_id: String
    var time: String // needs to be converted to something else
    var home_runs: Int? //those really should be Ints
    var away_runs: Int?
    var home_team_name: String
    var away_team_name: String
    var human_state: String
    var field: Field
    var league: League
    var home_league_entry: Home_League_Entry
    var away_league_entry: Away_League_Entry
    var umpire_assignments: [Umpire_Assignments] // might need square brackets
    var scorer_assignments: [Scorer_Assignments]
    
    struct Field: Hashable, Codable {
        var name: String
        var city: String
        //var latitude: Double?
       // var longitude: Double?
    }
 
    struct League: Hashable, Codable {
        var id: Int
        var season: Int
        var name: String
    }
    
    struct Home_League_Entry: Hashable, Codable {
        var team: Team
    }
    
    struct Away_League_Entry: Hashable, Codable {
        var team: Team
    }
    
    struct Umpire_Assignments: Hashable, Codable {
        var license: License
    }
    
    struct Scorer_Assignments: Hashable, Codable {
        var license: License
    }
    
    struct License: Hashable, Codable {
        var person: Person
        var number: String
    }
    
    struct Person: Hashable, Codable {
        var first_name: String
        var last_name: String
    }
    
    struct Team: Hashable, Codable {
        var name: String
        var clubs: [Clubs]
    }
    
    //note the spaces here! --> sometimes used in example for arrays
    
    struct Clubs: Hashable, Codable {
        var id: Int
        var name: String
        var acronym: String
    }

    //those exist in BSM, but need to be mapped to home ballpark, also only in detail view
    
/*     private var field: Coordinates
     var locationCoordinate: CLLocationCoordinate2D {
      CLLocationCoordinate2D(
            latitude: field.latitude,
            longitude: field.longitude)
    }
*/
}

