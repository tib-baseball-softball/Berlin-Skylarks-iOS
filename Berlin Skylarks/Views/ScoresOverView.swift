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

struct ScoresOverView: View {
    var gamescore: GameScore
    
    var body: some View {
        VStack(spacing: ScoresItemSpacing) {
            HStack {
                Text("ID: \(gamescore.match_id)")
                    .italic()
                Spacer()
                Text(gamescore.time)
                    .italic()
            }
            .font(.subheadline)
            HStack {
                VStack {
                    Text("Guest")
                        .bold()
                    Image("Bird_whiteoutline")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    Text(gamescore.away_team_name)
                        .lineLimit(nil)
                }
                Spacer()
                
                //I should be super careful about force unwrapping here!
                
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
                    Image("Bird_whiteoutline")
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
                    
                    .foregroundColor(Color("AccentColor"))
            }
            .padding(ScoresItemPadding)
            .background(ScoresSubItemBackground)
            .cornerRadius(NewsItemCornerRadius)
            HStack {
                Text("Home Ballpark")
                    .italic()
                Spacer()
                Text("Berlin")
                    .italic()
            }.font(.subheadline)
        }
        .padding(ScoresItemPadding)
//        .background(ItemBackgroundColor) //not needed because of new list style
        .cornerRadius(NewsItemCornerRadius)
    }
}

struct ScoresOverView_Previews: PreviewProvider {
    static var previews: some View {
        ScoresOverView(gamescore: gamescores[4])
    }
}
