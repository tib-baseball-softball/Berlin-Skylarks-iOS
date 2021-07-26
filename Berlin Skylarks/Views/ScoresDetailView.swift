//
//  ScoresDetailView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 27.12.20.
//

import SwiftUI

struct ScoresDetailView: View {
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
    
    var body: some View {
        self.setCorrectLogo()
        return
            List {
            Section(header: Text("Main info")) {
                HStack {
                    Image(systemName: "list.bullet")
                    Text(gamescore.league.name)
                }.padding(ScoresItemPadding)
                HStack {
                    Image(systemName: "number")
                    Text("\(gamescore.match_id)")
                }
                .padding(ScoresItemPadding)
                HStack {
                    Image(systemName: "clock.fill")
                    Text(gamescore.time)
                }
                .padding(ScoresItemPadding)
            }
            Section(header: Text("Score")) {
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
                //don't want the darker background color with rounded corners here
              //  .padding(ScoresItemPadding)
              //  .background(ScoresSubItemBackground)
              //  .cornerRadius(NewsItemCornerRadius)
            }
            Section(header: Text("Location")) {
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
            Section(header: Text("Status")) {
                HStack {
                    Image(systemName: "text.justify")
                    Text("\(gamescore.human_state)")
                }
                .padding(ScoresItemPadding)
                HStack {
                    Image(systemName: "doc.fill")
                    //this needs to be adjusted for both states concerning scoresheet
                    Text("Scoresheet unavailable")
                }
                .padding(ScoresItemPadding)
            }
            Section(header: Text("Game officials")) {
                HStack {
                    Image(systemName: "person.fill")
                    Text(gamescore.umpire_assignments[0].license.person.first_name + " " + gamescore.umpire_assignments[0].license.person.last_name)
                    Spacer()
                    Text(gamescore.umpire_assignments[0].license.number)
                        .font(.caption)
                }.padding(ScoresItemPadding)
                HStack {
                    Image(systemName: "person.fill")
                    Text(gamescore.umpire_assignments[1].license.person.first_name + " " + gamescore.umpire_assignments[1].license.person.last_name)
                    Spacer()
                    Text(gamescore.umpire_assignments[1].license.number)
                        .font(.caption)
                }.padding(ScoresItemPadding)
                HStack {
                    Image(systemName: "pencil")
                    Text(gamescore.scorer_assignments[0].license.person.first_name + " " + gamescore.scorer_assignments[0].license.person.last_name)
                    Spacer()
                    Text(gamescore.scorer_assignments[0].license.number)
                        .font(.caption)
                }.padding(ScoresItemPadding)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Game Details")
    }
}

struct ScoresDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ScoresDetailView(gamescore: dummyGameScores[0])
    }
}
