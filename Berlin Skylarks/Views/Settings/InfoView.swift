//
//  InfoView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 27.12.20.
//

import SwiftUI

struct InfoView: View {
#if os(iOS)
    let appName = UIApplication.appName ?? "No App Name"
    let version = UIApplication.appVersion ?? "No Version"
    let build = UIApplication.appBuild ?? "No Build #"
#endif
    
#if os(macOS)
    let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "No App Name"
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "No Version"
    let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "No Build #"
#endif
    
    var body: some View {
        List {
#if !os(watchOS)
            HStack {
                Text("App Name:")
                Text(appName)
            }
            HStack {
                Text("App Version:")
                Text(version)
            }
            HStack {
                Text("Build Number:")
                Text(build)
            }
#endif
        }
#if !os(watchOS)
        .textSelection(.enabled)
#endif
        .navigationTitle("App Info")
    }
}

#Preview {
    InfoView()
}
