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

var away_team_logo: Image? = Image("App_road_team_logo")
var home_team_logo: Image? = Image("App_home_team_logo")

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
//    func correctNullScores() {
//        if gamescore.away_runs == nil {
//
//        }
//    }
    
    var body: some View {
        self.setCorrectLogo()
        return
            VStack(spacing: ScoresItemSpacing) {
            Text(gamescore.league.name)
            //Text(gamescore.away_league_entry.team.clubs.debugDescription)
            HStack {
                VStack {
                    Text("Guest")
                        .bold()
                    away_team_logo?
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    Text(gamescore.away_team_name)
                        .lineLimit(nil)
                }
                Spacer()
                
                //I should be super careful about forced unwrapping here --> this won't work once I have real data as games in the future do NOT have runs yet!
                
                Text(String(gamescore.away_runs!))
                    .font(.largeTitle)
                    .bold()
                    .padding(ScoresNumberPadding)
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
                        .lineLimit(nil)
                }
                Spacer()
                Text(String(gamescore.home_runs!))
                    .font(.largeTitle)
                    .bold()
                    .padding(ScoresNumberPadding)
                    
                    //todo: make the higher color red (or Skylarks color?)
                    
                    //.foregroundColor(Color("AccentColor"))
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
        ScoresOverView(gamescore: dummyGameScores[0])
    }
}
