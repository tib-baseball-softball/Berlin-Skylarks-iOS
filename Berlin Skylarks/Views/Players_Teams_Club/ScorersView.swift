//
//  ScorersView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 05.08.22.
//

import SwiftUI

struct ScorersView: View {
    @ObservedObject var licenseManager: LicenseManager
    
    var body: some View {
        NavigationStack {
            List {
                Section(footer: Text("Disclaimer: All license data is derived from BSM and managed by the BSVBB. The club has no control over the displayed data.")) {
                    if licenseManager.loadingInProgress == true {
                        LoadingView()
                    }
                    ForEach(licenseManager.scorers, id: \.self) { scorerLicense in
                        NavigationLink(destination: LicenseDetailView(license: scorerLicense)) {
                            LicenseRow(license: scorerLicense)
                        }
                    }
                    if licenseManager.loadingInProgress == false && licenseManager.scorers.isEmpty {
                        Text("There is no scorer data to display.")
                    }
                }
            }
            .navigationTitle("Team Scorers")
            .animation(.default, value: licenseManager.scorers)
            
            .refreshable {
                licenseManager.scorers = []
                await licenseManager.loadScorers()
            }
            
            .onAppear {
                if licenseManager.scorers.isEmpty {
                    Task {
                        await licenseManager.loadScorers()
                    }
                }
            }
        }
    }
}

struct ScorersView_Previews: PreviewProvider {
    static var previews: some View {
        ScorersView(licenseManager: LicenseManager())
    }
}
