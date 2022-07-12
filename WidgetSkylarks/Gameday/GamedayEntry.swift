//
//  GamedayEntry.swift
//  WidgetSkylarksExtension
//
//  Created by David Battefeld on 04.07.22.
//

import Foundation
import WidgetKit
import SwiftUI

struct GamedayEntry: TimelineEntry {
    let date: Date
    let gamescores: [GameScore]
}
