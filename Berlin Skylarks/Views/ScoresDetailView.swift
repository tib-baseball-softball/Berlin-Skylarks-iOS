//
//  ScoresDetailView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 27.12.20.
//

import SwiftUI

struct ScoresDetailView: View {
    var gamescore: GameScore
    var body: some View {
        List {
            HStack {
                Image(systemName: "list.bullet")
                Text(gamescore.league.name)
            }
            .padding(ScoresItemPadding)
            HStack {
                Image(systemName: "clock.fill")
                Text(gamescore.time)
            }
            .padding(ScoresItemPadding)
            VStack {
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
                }
                .padding(ScoresItemPadding)
                HStack {
                    Text(String(gamescore.away_runs!))
                        .font(.largeTitle)
                        .bold()
                        .padding(ScoresNumberPadding)
                    Spacer()
                    Text(String(gamescore.home_runs!))
                        .font(.largeTitle)
                        .bold()
                        .padding(ScoresNumberPadding)
                }
                .padding(ScoresItemPadding)
            }
            //not sure if I want the darker background color with rounded corners here
            .padding(ScoresItemPadding)
            .background(ScoresSubItemBackground)
            .cornerRadius(NewsItemCornerRadius)
            HStack {
                Image(systemName: "diamond.fill") //this really needs a custom icon
                Text(String(describing:  gamescore.field.name))
            }
            .padding(ScoresItemPadding)
            HStack {
                Image(systemName: "house.fill")
                Text(String(describing:  gamescore.field.city))
            }
            .padding(ScoresItemPadding)
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Detail View")
    }
}

struct ScoresDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ScoresDetailView(gamescore: gamescores[0])
    }
}
