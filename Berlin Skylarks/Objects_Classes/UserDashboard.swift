//
//  UserDashboard.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 27.04.22.
//

import Foundation


//-------------------------------DASHBOARD---------------------------------//

class UserDashboard: ObservableObject {
    @Published var leagueTable = emptyTable
    
    @Published var tableRow = emptyRow
    
    @Published var NextGame = testGame
    
    @Published var LastGame = testGame
}
