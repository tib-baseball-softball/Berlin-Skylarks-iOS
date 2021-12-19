//
//  TestView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.09.21.
//

import SwiftUI
import MapKit

struct TestView: View {
    
    var favoriteTeam = UserDefaults.standard.codableObject(dataType: Team.self, key: "favoriteTeam")
    
    var body: some View {
        VStack {
            Text(favoriteTeam?.name ?? "No favorite team selected")
            Text(favoriteTeam?.ageGroup ?? "no age group")
            Text(favoriteTeam?.leagueName ?? "no league")
        }
    }
    //this is how you can declare functions in a view!
    
    private func printSomething() {
        print(self)
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            TestView().preferredColorScheme($0)
        }
    }
}
