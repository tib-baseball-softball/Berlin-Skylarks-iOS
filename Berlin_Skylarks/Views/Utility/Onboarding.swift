//
//  Onboarding.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 25.08.24.
//

import Foundation
import SwiftUI
import WidgetKit

struct OnboardingModifier: ViewModifier {
    @Binding var showingSheetOnboarding: Bool
    @Binding var didLaunchBefore: Bool

    func body(content: Content) -> some View {
        content
            .onAppear {
                checkForOnboarding()
                #if !os(watchOS)
                WidgetCenter.shared.reloadAllTimelines()
                #endif
            }
            .sheet(isPresented: $showingSheetOnboarding, onDismiss: {
                didLaunchBefore = true
            }) {
                UserOnboardingView()
                #if os(watchOS)
                    .navigationBarHidden(true)
                #endif
            }
    }
    
    private func checkForOnboarding() {
        if didLaunchBefore == false {
            showingSheetOnboarding = true
        }
    }
}

extension View {
    func onboarding(showingSheetOnboarding: Binding<Bool>, didLaunchBefore: Binding<Bool>) -> some View {
        self.modifier(OnboardingModifier(showingSheetOnboarding: showingSheetOnboarding, didLaunchBefore: didLaunchBefore))
    }
}
