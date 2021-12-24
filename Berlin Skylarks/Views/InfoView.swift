//
//  InfoView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 27.12.20.
//

import SwiftUI

struct InfoView: View {
    
    @ObservedObject var userSettings = UserSettings()

    var body: some View {
        
        VStack {
            Text("Favorite Team from user settings:")
            Text(userSettings.favoriteTeam)
        }
        
        
        //this is how you can declare functions in a view!
    }
    private func printSomething() {
        print(self)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
