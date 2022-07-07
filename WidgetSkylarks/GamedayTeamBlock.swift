//
//  GamedayTeamBlock.swift
//  WidgetSkylarksExtension
//
//  Created by David Battefeld on 04.07.22.
//

import SwiftUI
import WidgetKit

struct GamedayTeamBlock: View {
    
    var gamescore: GameScore
    
    @Environment(\.widgetFamily) var widgetFamily
    
    @State var roadLogo = away_team_logo
    @State var homeLogo = home_team_logo
    
    func setLogos() {
        let logos = fetchCorrectLogos(gamescore: gamescore)
        roadLogo = logos.road
        homeLogo = logos.home
    }
    
    var isExtraLarge: Bool {
        if widgetFamily == .systemExtraLarge {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text(gamescore.league.acronym)
                        .font(isExtraLarge ? .subheadline.smallCaps() : .caption.smallCaps())
                        .foregroundColor(.skylarksRed)
                    if let gameDate = gamescore.gameDate {
                        HStack {
                            Text(gameDate, format: Date.FormatStyle().weekday())
                            Text(gameDate, style: .date)
                            Text(gameDate, style: .time)
                        }
                        .foregroundColor(.secondary)
                    }
                }
                Divider()
                    .offset(x: 0, y: -3)
                HStack {
                    roadLogo
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: isExtraLarge ? 30 : 15, maxHeight: isExtraLarge ? 30 : 15)
                    Text(gamescore.away_league_entry.team.short_name)
                    Spacer()
                    if let awayScore = gamescore.away_runs, let homeScore = gamescore.home_runs {
                        ScoreNumber(displayScore: awayScore, otherScore: homeScore)
                            .font(isExtraLarge ? .subheadline.bold() : .caption.bold())
                            
                    }
                }
                HStack {
                    homeLogo
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: isExtraLarge ? 30 : 15, maxHeight: isExtraLarge ? 30 : 15)
                    Text(gamescore.home_league_entry.team.short_name)
                    Spacer()
                    if let awayScore = gamescore.away_runs, let homeScore = gamescore.home_runs {
                        ScoreNumber(displayScore: homeScore, otherScore: awayScore)
                            .font(isExtraLarge ? .subheadline.bold() : .caption.bold())
                    }
                }
            }
        }
        .font(isExtraLarge ? .subheadline : .caption)
        .padding(4)
        //.foregroundColor(.white)
        .background(ContainerRelativeShape().fill(Color(UIColor.secondarySystemBackground)))
        .overlay(RoundedRectangle(cornerRadius: 5)
            .stroke(Color.skylarksSand)
        )
        .onAppear(perform: {
            setLogos()
        })
    }
}

struct GamedayTeamBlock_Previews: PreviewProvider {
    static var previews: some View {
        GamedayTeamBlock(gamescore: dummyGameScores[0])
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
