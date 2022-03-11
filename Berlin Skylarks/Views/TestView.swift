//
//  TestView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.09.21.
//

import SwiftUI
import MapKit

struct TestView: View {

    var gamescore: GameScore
    
    var body: some View {
        NavigationView {
            List {
                VStack {
                    HStack {
                        home_team_logo
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 30, alignment: .center)
                        Text(gamescore.home_league_entry.team.short_name)
                            .font(.caption)
                            .padding(.leading)
                        Spacer()
                    }
                }
                .padding(.vertical)
            }
            //.font(.footnote)
            //.padding()
            #if !os(watchOS)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Image(systemName: "list.bullet.circle")
                }
                ToolbarItemGroup(placement: .principal) {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                }
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Image(systemName: "calendar.badge.plus")
                }
            }
#endif
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(gamescore: dummyGameScores[60])
    }
}
