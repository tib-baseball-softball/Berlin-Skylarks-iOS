//
//  SettingsListView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 27.12.20.
//

import SwiftUI

struct SettingsListView: View {
    
//    this is lazily copied, needs further understanding
    @State private var showGreeting = false
    
    var body: some View {
        NavigationView {
            List {
                VStack {
                    Toggle(isOn: $showGreeting) {
                            Text("Show welcome message")
                        }
                        .padding()
                    .toggleStyle(SwitchToggleStyle(tint: Color("AccentColor")))

                        if showGreeting {
                            Text("This is my personal test switch!")
                        }
                }
                NavigationLink(
                    destination: InfoView()) {
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .font(.title)
                        Spacer()
                        Text("App Info")
                        Spacer()
                    }
                }
            }
        }
    }
}

struct SettingsListView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsListView()
    }
}
