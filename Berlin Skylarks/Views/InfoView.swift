//
//  InfoView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 27.12.20.
//

import SwiftUI

struct InfoView: View {
    
    @ObservedObject var userSettings = UserSettings()
    @AppStorage("selectedSeason") var selectedSeason = Calendar(identifier: .gregorian).dateComponents([.year], from: .now).year!

    var body: some View {
        
        VStack {
            Text("Favorite Team from user settings:")
            Text(userSettings.favoriteTeam)
        }
        
        VStack {
            Text("selected season according to AppStorage:")
            Text(String(selectedSeason))
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
