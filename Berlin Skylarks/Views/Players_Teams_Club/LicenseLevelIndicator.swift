//
//  LicenseLevelIndicator.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 05.08.22.
//

import SwiftUI

struct LicenseLevelIndicator: View {
    
    var level: String
    
    var licenseColor: Color {
        if level.contains("A") {
            return .red
        } else if level.contains("B") {
            return .orange
        } else if level.contains("C") {
            return .yellow
        } else if level.contains("D") {
            return .mint
        }
        //this should never happen, but let's make it futureproof
        return .gray
    }
    
    var body: some View {
        Image(systemName: "\(level.lowercased()).square.fill")
            .foregroundColor(licenseColor)
    }
}

struct LicenseLevelIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LicenseLevelIndicator(level: "B")
    }
}
