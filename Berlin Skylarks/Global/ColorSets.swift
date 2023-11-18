//
//  ColorSets.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 24.12.20.
//

import Foundation
import SwiftUI

#if !os(watchOS) && !os(macOS)
let ScoresSubItemBackground = Color(UIColor.tertiarySystemFill)
let ColorStandingsTableHeadline = Color(UIColor.secondarySystemFill)

let ItemBackgroundColor = Color(UIColor.tertiarySystemFill)
//let PageBackgroundColor = Color(UIColor.secondarySystemBackground) //using standard backgrounds for now

//is that one actually needed?
let colorStandingsBackground = Color(UIColor.systemGroupedBackground)
#endif

#if os(macOS)
let ScoresSubItemBackground = Color(NSColor.tertiarySystemFill)
let ColorStandingsTableHeadline = Color(NSColor.secondarySystemFill)
let colorStandingsBackground = Color(NSColor.quaternarySystemFill)
#endif

extension Color {
    static let skylarksRed = Color(red: 186 / 255, green: 12 / 255, blue: 47 / 255)
    static let skylarksBlue = Color(red: 4 / 255, green: 30 / 255, blue: 66 / 255)
    static let skylarksSand = Color(red: 206 / 255, green: 184 / 255, blue: 136 / 255)
    //this is not adapting to dark mode!
    static let backgroundGrayPreview = Color(red: 58 / 255, green: 58 / 255, blue: 60 / 255)
    
    static let skylarksAdaptiveBlue = Color("SkylarksAdaptiveBlue")
    static let skylarksDynamicNavySand = Color("SkylarksDynamicNavySand")
    
    #if !os(watchOS) && !os(macOS)
    static let primaryBackground = Color(uiColor: .systemBackground)
    static let secondaryBackground = Color(uiColor: .secondarySystemBackground)
    #endif
}
