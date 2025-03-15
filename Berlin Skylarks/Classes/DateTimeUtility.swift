//
//  DateTimeUtility.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.12.24.
//

import Foundation

/// Utility class to help with isolated date and time-related tasks.
class DateTimeUtility {
    /// Calculates a person's age from a given ``TimeInterval``
    public static func getAge(from birthday: TimeInterval) -> Int {
        let birthDate = Date(timeIntervalSince1970: birthday)
        let calendar = Calendar.current
        
        let birthYear = calendar.component(.year, from: birthDate)
        let birthMonth = calendar.component(.month, from: birthDate)
        let birthDay = calendar.component(.day, from: birthDate)
        
        let currentDate = Date()
        let currentYear = calendar.component(.year, from: currentDate)
        let currentMonth = calendar.component(.month, from: currentDate)
        let currentDay = calendar.component(.day, from: currentDate)
        
        var age = currentYear - birthYear
        if currentMonth < birthMonth || (currentMonth == birthMonth && currentDay < birthDay) {
            age -= 1
        }
        
        return age
    }
    
    public static func formatTime(time: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(identifier: "UTC") // backend times are in UTC
        
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let timeString = formatter.string(from: date)
        
        return timeString
    }
    
    /// Parses a BSM-specific time string into a ``Date`` object
    ///
    /// TODO: refactor to accept string parameter
    public static func getDatefromBSMString(gamescore: GameScore) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y-M-dd HH:mm:ss Z"
        
        return dateFormatter.date(from: gamescore.time) ?? Date()
    }
}
