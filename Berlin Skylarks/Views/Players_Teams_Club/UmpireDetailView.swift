//
//  UmpireDetailView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 05.08.22.
//

import SwiftUI

struct UmpireDetailView: View {
    var license: BSMLicense
    
    var body: some View {
        List {
            Section {
                HStack {
                    LicenseLevelIndicator(level: license.level)
                            .font(.title)
                    Text(license.category)
                }
                if license.baseball {
                    HStack {
                        LicenseSportIndicator(baseball: true)
                        Text("Baseball")
                    }
                }
                if license.softball {
                    HStack {
                        LicenseSportIndicator(baseball: false)
                        Text("Softball")
                    }
                }
                if let sleeveNumber = license.sleeve_number {
                    HStack {
                        Image(systemName: "tshirt")
                            .clubIconStyleDynamic()
                        Text("\(sleeveNumber)")
                            .bold()
                            .font(.title3)
                            .padding(.horizontal, 8)
                    }
                }
            }
            Section {
                HStack {
                    Image(systemName: "person.fill")
                        .clubIconStyleDynamic()
                    Text("\(license.person.first_name) \(license.person.last_name)")
                        #if !os(watchOS)
                        .textSelection(.enabled)
                    #endif
                }
                HStack {
                    Image(systemName: "number")
                        .clubIconStyleDynamic()
                    Text(license.number)
                        #if !os(watchOS)
                        .textSelection(.enabled)
                    #endif
                }
                HStack {
                    Image(systemName: "calendar")
                        .clubIconStyleDynamic()
                    if let expiryDate = license.expiryDate {
                        Text(expiryDate, style: .date)
                    } else {
                        Text("No date info.")
                    }
                }
                if let expiryDate = license.expiryDate {
                    HStack {
                        Image(systemName: "timer")
                            .clubIconStyleDynamic()
                        Text(expiryDate, style: .relative)
                    }
                }
            }
        }
        .navigationTitle("License Detail")
    }
}

struct UmpireDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UmpireDetailView(license: previewLicense)
        }
    }
}
