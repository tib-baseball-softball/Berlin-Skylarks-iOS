//
//  SegmentStreak.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 24.05.22.
//

import SwiftUI

struct SegmentStreak: View {
    
    @ObservedObject var userDashboard: UserDashboard
    
    private func getStreak() -> Int {
        let streak = userDashboard.tableRow.streak
        var streakNumber: Int = 0
        if let number = Int(streak.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
            print(number)
            streakNumber = number
        }
        return streakNumber
    }
    
    var body: some View {
        StreakNumberView(userDashboard: userDashboard)
        
        StreakBar(value: 8, total: 20)
        
        StreakEmoji()
    }
}

struct SegmentStreak_Previews: PreviewProvider {
    static var previews: some View {
        List {
            SegmentStreak(userDashboard: dummyDashboard)
        }
        .preferredColorScheme(.dark)
    }
}
