//
//  TeamsLoader.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 07.11.22.
//

import Foundation

@MainActor
class TeamsLoader: ObservableObject {
    @Published var teams: [BSMTeam] = []
    @Published var loadingInProgress = false
    
    func loadTeamData(selectedSeason: Int) async {
        
        let teamURL = URL(string:"https://bsm.baseball-softball.de/clubs/485/teams.json?filters[seasons][]=" + "\(selectedSeason)" + "&sort[league_sort]=asc&api_key=" + apiKey)!
        
        loadingInProgress = true
        
        do {
            teams = try await fetchBSMData(url: teamURL, dataType: [BSMTeam].self)
        } catch {
            print("Request failed with error: \(error)")
        }
        loadingInProgress = false
    }
    
    func getFavoriteTeam(favID: Int) -> BSMTeam {
        var localTeam = emptyTeam
        for team in teams where team.id == favID {
            localTeam = team
        }
        return localTeam
    }
}
