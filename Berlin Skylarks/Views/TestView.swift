//
//  TestView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.09.21.
//

import SwiftUI
import MapKit

struct TestView: View {

    //var gamescore: GameScore
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Color(colorScheme == .light ? .secondarySystemBackground : .systemBackground)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Link below")
                List {
                    Section(header: Text("header")) {
                        Text("some")
                        Text("elements")
                        Text("in list")
                    }
                }
                .listStyle(.insetGrouped)
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TestView()
        }
            //.preferredColorScheme(.dark)
            //.previewInterfaceOrientation(.landscapeLeft)
    }
}
