//
//  ScoresTeamBar.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 13.10.22.
//

import SwiftUI

struct ScoresTeamBar: View {
    
    var teamLogo: Image
    var gamescore: GameScore
    var home: Bool
    
    var body: some View {
        HStack {
            teamLogo
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 40, alignment: .center)
            Text(gamescore.away_team_name)
                .padding(.leading)
            Spacer()
            if let awayScore = gamescore.away_runs, let homeScore = gamescore.home_runs {
                Text(home ? String(homeScore) : String(awayScore))
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: 40, alignment: .center)
                    .foregroundColor(home ? awayScore > homeScore ? Color.secondary : Color.primary : awayScore < homeScore ? Color.secondary : Color.primary)
            }
        }
    }
}

struct ScoresTeamBar_Previews: PreviewProvider {
    static var previews: some View {
        ScoresTeamBar(teamLogo: skylarksSecondaryLogo, gamescore: testGame, home: true)
    }
}
