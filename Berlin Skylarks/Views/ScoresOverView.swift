//
//  ScoresOverView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 27.12.20.
//

import SwiftUI

let ScoresItemSpacing: CGFloat = 20.0
let ScoresNumberPadding: CGFloat = 20.0
let ScoresSubItemBackground = Color(UIColor.tertiarySystemFill)
let ScoresItemPadding: CGFloat = 10.0
let teamNameFrame: CGFloat = 120

var away_team_logo: Image? = Image("App_road_team_logo")
var home_team_logo: Image? = Image("App_home_team_logo")

var gameDate: Date?

let teamLogos = [
    "Skylarks": Image("Bird_whiteoutline"),
    "Roosters": Image("Roosters_Logo"),
    "Sluggers": Image("Sluggers_Logo"),
    "Eagles": Image("Mahlow-Eagles_Logo"),
    "Ravens": Image("ravens_logo"),
    "Porcupines": Image("potsdam_logo"),
    "Sliders": Image("Sliders_logo"),
    "Flamingos": Image("Berlin_Flamingos_Logo_3D"),
    "Challengers": Image("challengers_Logo"),
    "Rams": Image("Rams-Logo"),
    "Wizards": Image("Wizards_Logo"),
    "Poor Pigs": Image("Poorpigs_Logo"),
    "Dukes": Image("Dukes_Logo"),
    "Roadrunners": Image("Roadrunners_Logo"),
    "Dragons": Image("Dragons_Logo"),
]


struct ScoresOverView: View {
    var gamescore: GameScore
    
    func setCorrectLogo() {
        for (name, image) in teamLogos {
            if gamescore.away_team_name.contains(name) {
                away_team_logo = image //teamLogos[name]
            }
        }
        
        for (name, image) in teamLogos {
            if gamescore.home_team_name.contains(name) {
                home_team_logo = image //teamLogos[name]
            }
        }
    }
    
    func getDatefromBSMString() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y-M-dd HH:mm:ss Z"
        
        //force unwrapping alert: gametime really should be a required field in BSM DB - let's see if there are crashes
        gameDate = dateFormatter.date(from: gamescore.time)!
    }
    
    var body: some View {
        self.setCorrectLogo()
        self.getDatefromBSMString()
        return
            VStack(spacing: ScoresItemSpacing) {
                VStack {
                    Text(gamescore.league.name)
                        .font(.headline)
                    HStack {
                        Image(systemName: "calendar")
                        Text(gameDate!, style: .date)
                        Image(systemName: "clock.fill")
                        Text(gameDate!, style: .time)
                    }.padding(ScoresItemPadding)
                }
            HStack {
                VStack {
                    Text("Guest")
                        .bold()
                    away_team_logo?
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    Text(gamescore.away_team_name)
                        .frame(width: teamNameFrame)
                        .lineLimit(nil)
                }
                Spacer()
                
                if let awayScore = gamescore.away_runs {
                    Text(String(awayScore))
                        .font(.largeTitle)
                        .bold()
                        .padding(ScoresNumberPadding)
                        .foregroundColor(gamescore.away_team_name.contains("Skylarks") ? Color.accentColor : Color.primary)
                }
                
            }
            .padding(ScoresItemPadding)
            .background(ScoresSubItemBackground)
            .cornerRadius(NewsItemCornerRadius)
            HStack {
                VStack {
                    Text("Home")
                        .bold()
                    home_team_logo?
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    Text(gamescore.home_team_name)
                        .frame(width: teamNameFrame)
                        .lineLimit(nil)
                }
                Spacer()
                
                if let homeScore = gamescore.home_runs {
                    Text(String(homeScore))
                        .font(.largeTitle)
                        .bold()
                        .padding(ScoresNumberPadding)
                        .foregroundColor(gamescore.home_team_name.contains("Skylarks") ? Color.accentColor : Color.primary)
                }
                
            }
            .padding(ScoresItemPadding)
            .background(ScoresSubItemBackground)
            .cornerRadius(NewsItemCornerRadius)
        }
        .padding(ScoresItemPadding)
//        .background(ItemBackgroundColor) //not needed because of new list style
        .cornerRadius(NewsItemCornerRadius)
    }
}

struct ScoresOverView_Previews: PreviewProvider {
    
    static var previews: some View {
        ScoresOverView(gamescore: dummyGameScores[36])
    }
}
