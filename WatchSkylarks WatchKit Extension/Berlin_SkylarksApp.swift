//
//  Berlin_SkylarksApp.swift
//  WatchSkylarks WatchKit Extension
//
//  Created by David Battefeld on 02.11.21.
//

import SwiftUI

@main
struct Berlin_SkylarksApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            ContentView()
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
