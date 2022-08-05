//
//  ClubView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 19.07.22.
//

import SwiftUI

struct ClubView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var networkManager: NetworkManager
    @State private var showAlertNoNetwork = false
    
    @State private var loadingInProgress = false
    
    @StateObject var clubData = ClubData()
    @StateObject var licenseManager = LicenseManager()
    
    func loadClubData() async {
        if networkManager.isConnected == false {
            showAlertNoNetwork = true
        }
        
        //our ID 485 should really never change
        let clubURL = URL(string:"https://bsm.baseball-softball.de/clubs/485.json?api_key=" + apiKey)!
        
        loadingInProgress = true
        
        do {
            clubData.club = try await fetchBSMData(url: clubURL, dataType: BSMClub.self)
        } catch {
            print("Request failed with error: \(error)")
        }
        loadingInProgress = false
    }
    
    var body: some View {
        ZStack {
            #if !os(watchOS)
            Color(colorScheme == .light ? .secondarySystemBackground : .systemBackground)
                .edgesIgnoringSafeArea(.all)
            #endif
            ScrollView {
                ClubInfoSection(clubData: clubData)
                    .padding(.horizontal)
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150, maximum: 200))]) {
                    NavigationLink(destination: ClubDetailView(clubData: clubData)){
                        ClubGridItem(systemImage: "info.circle.fill", itemName: "Detailed Info")
                            .padding(3)
                    }
                    NavigationLink(destination: UmpireView(licenseManager: licenseManager)) {
                        ClubGridItem(systemImage: "person.crop.rectangle.stack", itemName: "Umpire")
                            .padding(3)
                    }
                    ClubGridItem(systemImage: "pencil", itemName: "Scorer")
                        .padding(3)
                    NavigationLink(destination: TeamListView()){
                        ClubGridItem(systemImage: "person.3.fill", itemName: "Teams")
                            .padding(3)
                    }
                    ClubGridItem(systemImage: "diamond.fill", itemName: "Ballpark")
                        .padding(3)
//                    ClubGridItem(systemImage: "person.fill", itemName: "Coaches")
//                        .padding(3)
                    ClubGridItem(systemImage: "person.2.fill", itemName: "Officials")
                        .padding(3)
                }
                .foregroundColor(.primary)
                .padding([.top, .horizontal])
                .navigationTitle("Club")
                
            }
        }
        .onAppear(perform: {
            //check for performance!
            Task {
                await loadClubData()
            }
        })
        
        .alert("No network connection", isPresented: $showAlertNoNetwork) {
            Button("OK") { }
        } message: {
            Text("No active network connection has been detected. The app needs a connection to download its data.")
        }
    }
}

struct ClubView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ClubView()
                .environmentObject(NetworkManager())
        }
        //.preferredColorScheme(.dark)
    }
}
