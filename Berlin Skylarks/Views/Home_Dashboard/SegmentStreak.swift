//
//  SegmentStreak.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 24.05.22.
//

import SwiftUI

struct SegmentStreak: View {
    
    @ObservedObject var userDashboard: UserDashboard
    
    private func getStreak() -> Double {
        //Internal logic: Losing Streak from L10 to Winning Streak W10. This gets converted to a simple scale from 0 to 20 and used as values for the slider. Every streak longer than 10 gets subsumed (should it ever happen).
        
        let streak = userDashboard.tableRow.streak
        //we start at 10 - right in the middle if there is no other data
        var streakNumber: Double = 10
        
        if streak.contains("W") {
            if let number = Int(streak.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
                streakNumber = Double(number) + 10
            }
        } else if streak.contains("L") {
            if let number = Int(streak.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
                streakNumber = 10 - Double(number)
            }
        }
        return streakNumber
    }
    
    private func getEmoji(streakNumber: Double) -> String {
        var emoji = "😐"
        
        if streakNumber <= 0 {
            emoji = "🪦"
        }
        if 1...2 ~= streakNumber {
            emoji = "😖"
        }
        if 3...4 ~= streakNumber {
            emoji = "☹️"
        }
        if 5...6 ~= streakNumber {
            emoji = "🙁"
        }
        if 7...8 ~= streakNumber {
            emoji = "😕"
        }
        if 9 ~= streakNumber {
            emoji = "😐"
        }
        if 10 ~= streakNumber {
            emoji = "😶"
        }
        if 11 ~= streakNumber {
            emoji = "🙂"
        }
        if 12...14 ~= streakNumber {
            emoji = "😀"
        }
        if 15...16 ~= streakNumber {
            emoji = "😄"
        }
        if 17...19 ~= streakNumber {
            emoji = "🤩"
        }
        if streakNumber >= 20 {
            emoji = "🏆"
        }
        return emoji
    }
    
    var body: some View {
        //calculate the correct value
        let value = getStreak()
        //we pass along the calculated value and a static 20
        StreakBar(userDashboard: userDashboard, value: value, total: 20)
        
        let emoji = getEmoji(streakNumber: value)
        StreakEmoji(emoji: emoji)
    }
}

struct SegmentStreak_Previews: PreviewProvider {
    static var previews: some View {
        List {
            SegmentStreak(userDashboard: UserDashboard())
        }
        //.preferredColorScheme(.dark)
    }
}
