//
//  InfoView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 27.12.20.
//

import SwiftUI

struct InfoView: View {

    var body: some View {
        Text("nix hier")
    
        //this is how you can declare functions in a view!
    }
    private func printSomething() {
        print(self)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
            .previewDevice("iPad Air (4th generation)")
            
    }
}
