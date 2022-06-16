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
    
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
    
    func checkForOnboarding() {
        if didLaunchBefore == false {
            showingSheetOnboarding = true
            //didLaunchBefore = true
        }
    }
    
    var body: some View {
        
        //MARK: iPhone/iPad/Mac
        
        #if !os(watchOS)
        //the interface on iPhone uses a tab bar at the bottom
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            MainTabView()
            .onAppear(perform: {
                checkForOnboarding()
                WidgetCenter.shared.reloadAllTimelines()
            })
            .sheet( isPresented: $showingSheetOnboarding, onDismiss: {
                didLaunchBefore = true
            }) {
                UserOnboardingView()
            }
        }
            
        //on iPad and macOS we use a sidebar navigation to make better use of the ample space
        
        if UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.userInterfaceIdiom == .mac {
            SidebarNavigationView()
                .onAppear(perform: {
                    checkForOnboarding()
                    WidgetCenter.shared.reloadAllTimelines()
                })
                .sheet( isPresented: $showingSheetOnboarding, onDismiss: {
                    didLaunchBefore = true
                }) {
                    UserOnboardingView()
                }
        }
        
        #endif
        
        //MARK: Apple Watch
        
        #if os(watchOS)
            WatchRootView()
    
            //TODO: needs to get favorite team info as well, either from parent app or via own view
            .onAppear(perform: {
                checkForOnboarding()
            })
            .sheet( isPresented: $showingSheetOnboarding, onDismiss: {
                didLaunchBefore = true
            }) {
                UserOnboardingView()
                    .navigationBarHidden(true)
            }
        #endif
    }
}

//preview settings

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
//                .padding(0.0).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
                //.previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
