//
//  InfoView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 27.12.20.
//

import SwiftUI

struct InfoView: View {

    var body: some View {
        List {
            #if !os(watchOS)
            HStack {
                Text("App Name:")
                if let name = UIApplication.appName {
                    Text(name)
                }
            }
            HStack {
                Text("App Version:")
                if let version = UIApplication.appVersion {
                    Text(version)
                }
            }
            HStack {
                Text("Build Number:")
                if let build = UIApplication.appBuild {
                    Text(build)
                }
            }
#endif
        }
#if !os(watchOS)
        .textSelection(.enabled)
#endif
        .navigationTitle("App Info")
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
