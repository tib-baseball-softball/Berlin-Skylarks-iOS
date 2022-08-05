//
//  LicenseManager.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 05.08.22.
//

import Foundation

@MainActor
class LicenseManager: ObservableObject {
    @Published var umpires: [BSMLicense] = []
    
    @Published var loadingInProgress = false
    
    func loadUmpires() async {
        loadingInProgress = true
        
        let umpireURL = URL(string: "https://bsm.baseball-softball.de/clubs/485/licenses.json?filters[categories][]=umpire&api_key=" + apiKey)!
        
        do {
            umpires = try await fetchBSMData(url: umpireURL, dataType: [BSMLicense].self)
        } catch {
            print("Request failed with error: \(error)")
        }
        
        for (index, _) in umpires.enumerated() {
            umpires[index].getExpiryDate()
        }
        
        loadingInProgress = false
    }
}
