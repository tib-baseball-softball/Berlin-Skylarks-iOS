//
//  InfoView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 27.12.20.
//

import SwiftUI

struct InfoView: View {
    
    @ObservedObject var userSettings = UserSettings()
    
    @ObservedObject var userDashboard = UserDashboard()

    var body: some View {
        
        VStack {
            Text("nix hier")
            Text(userSettings.favoriteTeam)
            Text("\(userDashboard.displayDashboardTableRow.wins_count)")
            Text(String(userDashboard.displayDashboardTableRow.losses_count))
            Text(userDashboard.displayDashboardTableRow.quota)
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
