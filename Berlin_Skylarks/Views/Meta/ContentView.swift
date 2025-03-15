//
//  ContentView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 23.12.20.
//

import SwiftUI
import CoreData

#if !os(watchOS)
import WidgetKit
#endif

struct ContentView: View {
    @State private var showingSheetOnboarding = false
    
    @AppStorage("didLaunchBefore") var didLaunchBefore = false
    @AppStorage("selectedSeason") var selectedSeason = Calendar(identifier: .gregorian).dateComponents([.year], from: .now).year!
    
    var body: some View {
        
        //MARK: iPhone/iPad
        
        #if os(iOS)
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            MainTabView()
                .onboarding(showingSheetOnboarding: $showingSheetOnboarding, didLaunchBefore: $didLaunchBefore)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            SidebarNavigationView()
                .onboarding(showingSheetOnboarding: $showingSheetOnboarding, didLaunchBefore: $didLaunchBefore)
        }
        
        #elseif os(macOS)
        SidebarNavigationView()
            .onboarding(showingSheetOnboarding: $showingSheetOnboarding, didLaunchBefore: $didLaunchBefore)
        #endif
            
        
        //MARK: Apple Watch
        
        #if os(watchOS)
        WatchRootView()
            .onboarding(showingSheetOnboarding: $showingSheetOnboarding, didLaunchBefore: $didLaunchBefore)
            //TODO: needs to get favorite team info as well, either from parent app or via own view
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
//                .padding(0.0).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
                //.previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
