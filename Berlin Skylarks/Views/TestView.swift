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
    
    //let calendars = getAvailableCalendars()
    
    var body: some View {
        
        Text("dfhbhjdfjc")
//        ForEach(calendars, id: \.self) { calendar in
//            Button(calendar.title) {
//                //gameDate = getDatefromBSMString(gamescore: gamescore)
//                let localGameDate = getDatefromBSMString(gamescore: dummyGameScores[47])
//                addGameToCalendar(gameDate: localGameDate, gamescore: dummyGameScores[4], calendar: calendar)
//                //showEventAlert = true
//
//            }
//        }
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
