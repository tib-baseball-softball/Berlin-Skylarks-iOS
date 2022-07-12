//
//  FavoriteTeamEntry.swift
//  WidgetSkylarksExtension
//
//  Created by David Battefeld on 04.07.22.
//

import Foundation
import WidgetKit
import SwiftUI

struct FavoriteTeamEntry: TimelineEntry {
    let date: Date
    let configuration: FavoriteTeamIntent
    let team: BSMTeam
    let lastGame: GameScore?
    let lastGameRoadLogo: Image
    let lastGameHomeLogo: Image
    let nextGame: GameScore?
    let nextGameOpponentLogo: Image
    let skylarksAreRoadTeam: Bool
    let Table: LeagueTable
    let TableRow: LeagueTable.Row
}
