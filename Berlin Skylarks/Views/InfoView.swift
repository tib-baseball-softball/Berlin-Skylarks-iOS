//
//  InfoView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 27.12.20.
//

//until I do stuff with it this is my test view

import SwiftUI

struct InfoView: View {

    var body: some View {
        List {
            Text("Test")
        }
        //.listStyle(.insetGrouped)
    }
    
    //this is how you can declare functions in a view!
    
    private func printSomething() {
        print(self)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
//.previewInterfaceOrientation(.portrait)
    }
}
