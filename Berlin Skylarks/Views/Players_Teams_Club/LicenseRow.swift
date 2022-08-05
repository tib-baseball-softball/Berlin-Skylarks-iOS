//
//  LicenseRow.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 05.08.22.
//

import SwiftUI

struct LicenseRow: View {
    var license: BSMLicense
    
    var body: some View {
        HStack {
            LicenseLevelIndicator(level: license.level)
                .font(.title)
                .clubIconStyleDynamic()
            Text("\(license.person.last_name), \(license.person.first_name)")
//            Spacer()
//            if license.baseball {
//                LicenseSportIndicator(baseball: true)
//            }
//            if license.softball {
//                LicenseSportIndicator(baseball: false)
//            }
        }
    }
}

struct LicenseRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            LicenseRow(license: previewLicense)
        }
        .preferredColorScheme(.dark)
    }
}
