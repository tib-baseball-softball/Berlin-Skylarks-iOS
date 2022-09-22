//
//  Berlin_SkylarksApp.swift
//  WatchSkylarks WatchKit Extension
//
//  Created by David Battefeld on 02.11.21.
//

import SwiftUI

@main
struct Berlin_SkylarksApp: App {
    
    //we're not using calendar shenanigans on the watch for now
    //@StateObject var calendarManager = CalendarManager()
    @StateObject var networkManager = NetworkManager()
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            ContentView()
                //.environmentObject(calendarManager)
                .environmentObject(networkManager)
        }

        //commented until I actually use notifications
        //WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
