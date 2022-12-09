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
    
    var body: some View {
        ZStack {
            #if !os(watchOS)
            Color(colorScheme == .light ? .secondarySystemBackground : .systemBackground)
                .edgesIgnoringSafeArea(.all)
#endif
            ScrollView {
                ClubInfoSection(clubData: clubData)
                    .padding(.horizontal)
#if !os(watchOS)
                let columns = [GridItem(.adaptive(minimum: 140, maximum: 200))]
#else
                let columns = [GridItem(.adaptive(minimum: 80, maximum: 100))]
#endif
                //TODO: Localize
                LazyVGrid(columns: columns) {
                    NavigationLink(destination: ClubDetailView(clubData: clubData)){
                        ClubGridItem(systemImage: "info.circle.fill", itemName: "Details")
                            .padding(3)
                    }
                    NavigationLink(destination: UmpireView(licenseManager: licenseManager)) {
                        ClubGridItem(systemImage: "person.crop.rectangle.stack", itemName: "Umpire")
                            .padding(3)
                    }
                    NavigationLink(destination: ScorersView(licenseManager: licenseManager)) {
                        ClubGridItem(systemImage: "pencil", itemName: "Scorer")
                            .padding(3)
                    }
                    NavigationLink(destination: TeamListView()){
                        ClubGridItem(systemImage: "person.3.fill", itemName: "Teams")
                            .padding(3)
                    }
                    NavigationLink(destination: BallparkView(clubData: clubData)) {
                        ClubGridItem(systemImage: "diamond.fill", itemName: "Ballpark")
                            .padding(3)
                    }
                    NavigationLink(destination: FunctionaryView(clubData: clubData)) {
                        ClubGridItem(systemImage: "person.2.fill", itemName: "Officials")
                            .padding(3)
                    }
                }
                .foregroundColor(.primary)
                .padding([.top, .horizontal])
                .navigationTitle("Club")
                
            }
        }
        .onAppear {
            //check for performance!
            Task {
                await clubData.loadClubData()
                await clubData.loadFields()
            }
        }
        
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
