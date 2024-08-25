//
//  Gameday.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 25.08.24.
//

import Foundation
import SwiftUI

enum Gameday: String, Identifiable, CaseIterable {
    case previous
    case current
    case next
    case any
    
    var displayName: String { rawValue.capitalized }
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue.capitalized) }
    var id: String { self.rawValue }
}
