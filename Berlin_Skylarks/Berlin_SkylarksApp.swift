//
//  Berlin_SkylarksApp.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 23.12.20.
//

import SwiftUI

@main
struct Berlin_SkylarksApp: App {
    @State var calendarManager = CalendarManager()
    @State var networkManager = NetworkManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(calendarManager)
                .environment(networkManager)
        }
    }
}

//this makes views immediately appear (instead of being hidden behind back buttons)
#if !os(macOS)
extension UISplitViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.show(.primary)
    }
}
#endif
