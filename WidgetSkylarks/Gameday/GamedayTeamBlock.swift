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
    
    @State var roadLogo = TeamImageData.away_team_logo
    @State var homeLogo = TeamImageData.home_team_logo
    
    func getShortDates(date: Date) -> (date: String, time: String) {
        let formatter1 = DateFormatter()
        let formatter2 = DateFormatter()
        formatter1.dateStyle = .short
        formatter2.timeStyle = .short
        
        let returnDate = formatter1.string(from: date)
        let returnTime = formatter2.string(from: date)
        
        return (returnDate, returnTime)
    }
    
    func setLogos() {
        let logos = TeamImageData.fetchCorrectLogos(gamescore: gamescore)
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
                        let dateInfo = getShortDates(date: gameDate)
                        HStack {
                            Text(dateInfo.date)
                            Text(dateInfo.time)
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
        .background(ContainerRelativeShape().fill(Color.secondaryBackground))
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
        GamedayTeamBlock(gamescore: testGame)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
