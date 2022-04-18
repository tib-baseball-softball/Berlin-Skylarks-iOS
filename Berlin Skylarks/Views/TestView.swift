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
        VStack {
            Text("Link below")
            NavigationLink( destination: ScoresView()) {
                Text("Link to Scores proper")
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
