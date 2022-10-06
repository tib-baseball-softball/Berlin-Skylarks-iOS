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
        
        Text("nothing")
//        Group {
//#if !os(watchOS)
//        Text("This is non-watchOS text")
//#else
//        Text("This text appears only on Watch")
//#endif
//        }
//        //this modifier is supposed to work for both platforms
//            .onAppear(perform: {
//                print("this is a pointless message")
//            })
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
