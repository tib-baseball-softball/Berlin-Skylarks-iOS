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

//if gamescore.away_team_name.contains("Skylarks") {
  //      away_team_logo = Image("Bird_whiteoutline")
   // }

struct ScoresOverView: View {
    var gamescore: GameScore
//    var teamlogo: TeamLogo
    
    var body: some View {
        VStack(spacing: ScoresItemSpacing) {
            Text(gamescore.league.name)
            Text(gamescore.away_league_entry.team.clubs.debugDescription)
            HStack {
                Text("ID: \(gamescore.match_id)")
                    .italic()
                Spacer()
                Text(gamescore.time)
                    .italic()
            }.font(.subheadline)
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
                
                //I should be super careful about force unwrapping here --> this won't work once I have real data as games in the future do NOT have runs yet!
                
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
            HStack {
                Text(String(describing:  gamescore.field.name))
                    .italic()
                Spacer()
                Text(String(describing:  gamescore.field.city))
                    .italic()
            }.font(.subheadline)
            HStack {
                Text("Status: \(gamescore.human_state)")
                    .italic()
                Spacer()
                Text("Scoresheet:")
                    .italic()
                Image(systemName: "doc.fill")
                    .font(.headline)
                    .foregroundColor(Color("AccentColor"))
            }.font(.subheadline)
        }
        .padding(ScoresItemPadding)
//        .background(ItemBackgroundColor) //not needed because of new list style
        .cornerRadius(NewsItemCornerRadius)
    }
}

struct ScoresOverView_Previews: PreviewProvider {
    static var previews: some View {
        ScoresOverView(gamescore: gamescores[0])
    }
}
