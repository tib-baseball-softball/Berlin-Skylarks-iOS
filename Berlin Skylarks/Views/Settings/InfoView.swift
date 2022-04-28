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
                Text("App version:")
                if let version = UIApplication.appVersion {
                    Text(version)
                }
            }
            #endif
            HStack {
                Text("Build:")
                Text("some build ID")
            }
        }
        .navigationTitle("App Info")
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
