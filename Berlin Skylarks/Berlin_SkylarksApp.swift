//
//  Berlin_SkylarksApp.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 23.12.20.
//

import SwiftUI

@main
struct Berlin_SkylarksApp: App {
    let persistenceController = PersistenceController.shared
    
    @StateObject var calendarManager = CalendarManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(calendarManager)
        }
    }
}

//this makes views immediately appear (instead of being hidden behind back buttons)

extension UISplitViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.show(.primary)
    }
}
