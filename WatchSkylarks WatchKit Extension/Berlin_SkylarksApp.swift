//
//  Berlin_SkylarksApp.swift
//  WatchSkylarks WatchKit Extension
//
//  Created by David Battefeld on 02.11.21.
//

import SwiftUI

@main
struct Berlin_SkylarksApp: App {
    @State var networkManager = NetworkManager()
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(networkManager)
        }
    }
}
