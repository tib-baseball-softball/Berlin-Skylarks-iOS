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
        switch level {
        case "A":
            return .red
        case "B":
            return .orange
        case "C":
            return .yellow
        case "D":
            return .mint
        default:
            return .gray
        }
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
