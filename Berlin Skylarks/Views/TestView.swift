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
        List {
            VStack {
                HStack {
                    away_team_logo
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 30, alignment: .center)
                    Text(gamescore.away_league_entry.team.short_name)
                        .font(.caption)
                        .padding(.leading)
                    Spacer()
                    if let awayScore = gamescore.away_runs {
                        Text(String(awayScore))
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: 40, alignment: .center)
                            .foregroundColor(gamescore.away_team_name.contains("Skylarks") ? Color.accentColor : Color.primary)
                    }
                }
                HStack {
                    home_team_logo
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 30, alignment: .center)
                    Text(gamescore.home_league_entry.team.short_name)
                        .font(.caption)
                        .padding(.leading)
                    Spacer()
                    if let homeScore = gamescore.home_runs {
                        Text(String(homeScore))
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: 40, alignment: .center)
                            .foregroundColor(gamescore.home_team_name.contains("Skylarks") ? Color.accentColor : Color.primary)
                    }
                }
            }
            .padding(.vertical)
        }
        //.font(.footnote)
        //.padding()
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(gamescore: dummyGameScores[60])
    }
}
