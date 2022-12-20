//
//  FavoriteTeamWidgetData.swift
//  WidgetSkylarksExtension
//
//  Created by David Battefeld on 13.10.22.
//

import Foundation

class FavoriteTeamWidgetData: ObservableObject {
    @Published var leagueTable = emptyTable
    
    @Published var tableRow = emptyRow
    
    @Published var NextGame = testGame
    @Published var LastGame = testGame
    
}
