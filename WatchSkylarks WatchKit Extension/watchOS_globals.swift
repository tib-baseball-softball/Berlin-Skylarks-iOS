//
//  watchOS_globals.swift
//  WatchSkylarks WatchKit Extension
//
//  Created by David Battefeld on 03.11.21.
//

import Foundation
import SwiftUI

//this file serves to define global variables that have unavailable values in watchOS
extension UIColor {
    static var mySystemGray5: UIColor {
        return .init(red: 229/255, green: 229/255, blue: 234/255, alpha: 1)
    }
}

let ScoresSubItemBackground = Color.secondary
let ColorStandingsTableHeadline = Color.gray

let colorStandingsBackground = Color(UIColor.mySystemGray5)
