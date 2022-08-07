//
//  ClubDataManager.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 19.07.22.
//

import Foundation

@MainActor
class ClubData: ObservableObject {
    @Published var club = BSMClub(id: 485, name: "Berlin Skylarks", short_name: "Skylarks", acronym: "BEA", organization_id: 9, number: 1100, headquarter: "Columbiadamm", main_club: "TiB", chairman: "Johannes Russ", registered_association: "VR xyz", court: "OLG Berlin", address_addon: "Geschäftsstelle", street: "Straße 12", postal_code: "12345", city: "Berlin", country: "DE", latitude: 0, longitude: 0, successes: "winning")
    
    @Published var functionaries: [BSMFunctionary] = []
    //@Published var fields: [BSMField] = []
    
    @Published var fieldObjects: [FieldObject] = []
    
    @Published var loadingInProgress = false
    
    func loadClubData() async {
//        if networkManager.isConnected == false {
//            showAlertNoNetwork = true
//        }
        
        //our ID 485 should really never change
        let clubURL = URL(string:"https://bsm.baseball-softball.de/clubs/485.json?api_key=" + apiKey)!
        
        loadingInProgress = true
        
        do {
            club = try await fetchBSMData(url: clubURL, dataType: BSMClub.self)
        } catch {
            print("Request failed with error: \(error)")
        }
        loadingInProgress = false
    }
    
    func loadFunctionaries() async {
        loadingInProgress = true
        
        let url = URL(string: "https://bsm.baseball-softball.de/clubs/485/club_functions.json?api_key=" + apiKey)!
        
        do {
            functionaries = try await fetchBSMData(url: url, dataType: [BSMFunctionary].self)
        } catch {
            print("Request failed with error: \(error)")
        }
        
        loadingInProgress = false
    }
    
    func loadFields() async {
        loadingInProgress = true
        
        var fields: [BSMField] = []
        fieldObjects = []
        
        let url = URL(string: "https://bsm.baseball-softball.de/clubs/485/fields.json?api_key=" + apiKey)!
        
        do {
            fields = try await fetchBSMData(url: url, dataType: [BSMField].self)
        } catch {
            print("Request failed with error: \(error)")
        }
        
        for field in fields {
            let object = FieldObject(field: field)
            fieldObjects.append(object)
        }
        
        loadingInProgress = false
    }
}
