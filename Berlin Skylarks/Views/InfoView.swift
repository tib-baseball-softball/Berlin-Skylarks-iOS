//
//  InfoView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 27.12.20.
//

import SwiftUI

struct InfoView: View {
    
    //@ObservedObject var userSettings = UserSettings()
    @AppStorage("selectedSeason") var selectedSeason = Calendar(identifier: .gregorian).dateComponents([.year], from: .now).year!
    @AppStorage("favoriteTeam") var favoriteTeam: String = ""
    
    @AppStorage("favoriteTeamID") var favoriteTeamID = 0

    var body: some View {
        VStack {
            Text("selected season according to AppStorage:")
            Text(String(selectedSeason))
        }
        .padding()
        VStack {
            Text("favoriteTeam:")
            Text(favoriteTeam.debugDescription)
        }
        .padding()
        VStack {
            Text("favoriteTeamID:")
            Text("\(favoriteTeamID)")
        }
        .padding()
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
