//
//  ScoresOverViewFull.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 18.04.22.
//

import SwiftUI

struct ScoresOverViewFull: View {
    
    var gamescore: GameScore
    
    @State var roadLogo = TeamImageData.away_team_logo
    @State var homeLogo = TeamImageData.home_team_logo
    
    func setLogos() {
        let logos = TeamImageData.fetchCorrectLogos(gamescore: gamescore)
        roadLogo = logos.road
        homeLogo = logos.home
    }
    
    //MARK: old version that takes a lot of screen space, not used right now
    var body: some View {
        VStack(spacing: 7) {
            VStack {
                Text(gamescore.league.name)
                    .font(.title3)
                    .bold()
                HStack {
                    VStack(alignment: .leading, spacing: 7) {
                        HStack {
                            Image(systemName: "calendar")
                            if let date = gamescore.gameDate {
                                Text(date, style: .date)
                            }
                        }
                        HStack {
                            Image(systemName: "clock.fill")
                            if let time = gamescore.gameDate {
                                Text(time, style: .time)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 1)
                    Spacer()
                    Divider()
                        .frame(height: 40)
                    Spacer()
                    GameResultIndicator(gamescore: gamescore)
                    Spacer()
                }
            }
            HStack {
                HStack {
                    roadLogo
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    Text(gamescore.away_team_name)
                        .padding(.leading)
                }
                Spacer()
                if let awayScore = gamescore.away_runs, let homeScore = gamescore.home_runs {
                    Text(String(awayScore))
                        .font(.largeTitle)
                        .bold()
                        .padding(.horizontal)
                        .foregroundColor(awayScore < homeScore ? Color.secondary : Color.primary)
                }
                
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(ScoresSubItemBackground)
            .cornerRadius(NewsItemCornerRadius)
            HStack {
                HStack {
                    homeLogo
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    Text(gamescore.home_team_name)
                        .padding(.leading)
                }
                Spacer()
                
                if let awayScore = gamescore.away_runs, let homeScore = gamescore.home_runs {
                    Text(String(homeScore))
                        .font(.largeTitle)
                        .bold()
                        .padding(.horizontal)
                        .foregroundColor(awayScore > homeScore ? Color.secondary : Color.primary)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(ScoresSubItemBackground)
            .cornerRadius(NewsItemCornerRadius)
            
        }
        .padding()
        .background(.regularMaterial) //switch on or off depending on whether I use List or Grid
        .cornerRadius(NewsItemCornerRadius)
        
        .onAppear(perform: {
            setLogos()
        })
    }
}

struct ScoresOverViewFull_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ScoresOverViewFull(gamescore: testGame)
        }
        //.preferredColorScheme(.dark)
    }
}
