//
//  StreakDataEntry.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 15.03.25.
//


/// a single entry for a team's winning or losing streak. Used in ``SegmentStreak`` and ``StreakBar``.
struct StreakDataEntry: Hashable {
    /// a game number - typed as a string because we don't want SwiftUI to dynamically leave out values on the x axis/
    var game: String
    /// whether our team has won the game corresponding to this entry's week
    var wonGame: Bool
    /// total count of wins as of this entry's week
    var winsCount: Int
}
