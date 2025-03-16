//
//  ContentView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 23.12.20.
//

import CoreData
import SwiftUI
import WidgetKit

struct ContentView: View {
    @State private var showingSheetOnboarding = false

    @AppStorage("didLaunchBefore") var didLaunchBefore = false
    @AppStorage("selectedSeason") var selectedSeason = Calendar(
        identifier: .gregorian
    ).dateComponents([.year], from: .now).year!

    var body: some View {
        #if os(iOS)

            if UIDevice.current.userInterfaceIdiom == .phone {
                MainTabView()
                    .onboarding(
                        showingSheetOnboarding: $showingSheetOnboarding,
                        didLaunchBefore: $didLaunchBefore)
            } else if UIDevice.current.userInterfaceIdiom == .pad {
                SidebarNavigationView()
                    .onboarding(
                        showingSheetOnboarding: $showingSheetOnboarding,
                        didLaunchBefore: $didLaunchBefore)
            }

        #elseif os(macOS)
            SidebarNavigationView()
                .onboarding(
                    showingSheetOnboarding: $showingSheetOnboarding,
                    didLaunchBefore: $didLaunchBefore)
        #endif
    }
}

#Preview {
    ContentView()
}
