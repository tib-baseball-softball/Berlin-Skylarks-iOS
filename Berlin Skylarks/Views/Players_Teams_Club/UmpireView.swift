//
//  UmpireView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 05.08.22.
//

import SwiftUI

struct UmpireView: View {
    @ObservedObject var licenseManager: LicenseManager
    
    var body: some View {
        List {
            Section(
                header: HStack {
                    LicenseSportIndicator(baseball: true)
                    Text("Baseball")
                }
                //footer: Text("Disclaimer: All license data is derived from BSM and managed by the BSVBB. The club has no control over the displayed data.")
            ) {
                if licenseManager.loadingInProgress == true {
                    LoadingView()
                }
                ForEach(licenseManager.umpires, id: \.self) { umpireLicense in
                    if umpireLicense.baseball == true {
                        NavigationLink(destination: LicenseDetailView(license: umpireLicense)) {
                            LicenseRow(license: umpireLicense)
                        }
                    }
                }
                if licenseManager.loadingInProgress == false && licenseManager.umpires.isEmpty {
                    Text("There is no umpire data to display.")
                }
            }
            Section(
                header: HStack {
                    LicenseSportIndicator(baseball: false)
                    Text("Softball")
                },
                footer: Text("Disclaimer: All license data is derived from BSM and managed by the BSVBB. The club has no control over the displayed data.")
            ) {
                if licenseManager.loadingInProgress == true {
                    LoadingView()
                }
                ForEach(licenseManager.umpires, id: \.self) { umpireLicense in
                    if umpireLicense.softball == true {
                        NavigationLink(destination: LicenseDetailView(license: umpireLicense)) {
                            LicenseRow(license: umpireLicense)
                        }
                    }
                }
                if licenseManager.loadingInProgress == false && licenseManager.umpires.isEmpty {
                    Text("There is no umpire data to display.")
                }
            }
        }
        .navigationTitle("Team Umpires")
        .animation(.default, value: licenseManager.umpires)
        
        .refreshable {
            licenseManager.umpires = []
            await licenseManager.loadUmpires()
        }
        
        .onAppear {
            if licenseManager.umpires.isEmpty {
                Task {
                    await licenseManager.loadUmpires()
                }
            }
        }
    }
}

struct UmpireView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UmpireView(licenseManager: LicenseManager())
        }
    }
}
