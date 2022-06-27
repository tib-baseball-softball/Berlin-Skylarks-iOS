//
//  IntentHandler.swift
//  Skylarks Intents
//
//  Created by David Battefeld on 31.03.22.
//

import Intents
import Foundation

class IntentHandler: INExtension, FavoriteTeamIntentHandling {
    
//    func provideTeamOptionsCollection(for intent: FavoriteTeamIntent, with completion: @escaping (INObjectCollection<BEATeam>?, Error?) -> Void) {
//        <#code#>
//    }
    
    func provideTeamOptionsCollection(for intent: FavoriteTeamIntent) async throws -> INObjectCollection<BEATeam> {
        
        //widgets don't make any sense with anything except the current year, so it is always set to that
        let teams = try await loadSkylarksTeams(season: Calendar(identifier: .gregorian).dateComponents([.year], from: .now).year!)
        
        let teamOptions = teams.map { (team) -> BEATeam in
            if !team.league_entries.isEmpty {
                let someTeam = BEATeam(identifier: team.league_entries[0].league.name, display: team.league_entries[0].league.name)
                return someTeam
            } else {
                return BEATeam(identifier: "League Name", display: "League Name")
            }
        }
        
        let collection = INObjectCollection(items: teamOptions)
        return collection
    }
    
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}
