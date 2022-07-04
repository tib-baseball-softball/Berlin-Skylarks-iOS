//
//  ScoreNumber.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 04.07.22.
//

import SwiftUI

struct ScoreNumber: View {
    
    var displayScore: Int
    var otherScore: Int
    
    var body: some View {
        Text(String(displayScore))
            .foregroundColor(displayScore < otherScore ? Color.secondary : Color.primary)
            //was hidden on Mac, watch if this helps
            .fixedSize(horizontal: false, vertical: true)
    }
}

//struct ScoreNumber_Previews: PreviewProvider {
//    static var previews: some View {
 //       ScoreNumber(homeScore: 5, awayScore: 6, displayScore: 5)
 //   }
//}
