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
    
    func getDatefromBSMString() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y-M-dd HH:mm:ss Z"
        
        //force unwrapping alert: game time really should be a required field in BSM DB - let's see if there are crashes
        gameDate = dateFormatter.date(from: gamescore.time)!
    }
    
    var body: some View {
        self.setCorrectLogo()
        self.getDatefromBSMString()
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
                    Image(systemName: "calendar")
                    Text(gameDate!, style: .date)
                }
                .padding(ScoresItemPadding)
                HStack {
                    Image(systemName: "clock.fill")
                    Text(gameDate!, style: .time)
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
                                //.frame(width: teamNameFrame)
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
                                //.frame(width: teamNameFrame)
                                .lineLimit(nil)
                        }.frame(width: teamNameFrame)
                    }
                    .padding(ScoresItemPadding)
                    HStack {
                        if let awayScore = gamescore.away_runs {
                            Text(String(awayScore))
                                .font(.largeTitle)
                                .bold()
                                .padding(ScoresNumberPadding)
                                .foregroundColor(gamescore.away_team_name.contains("Skylarks") ? Color.accentColor : Color.primary)
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
                }
                //don't want the darker background color with rounded corners here
              //  .padding(ScoresItemPadding)
              //  .background(ScoresSubItemBackground)
              //  .cornerRadius(NewsItemCornerRadius)
            }
            Section(header: Text("Location")) {
                
                //TODO: add mapKit View here and map to location
                
                //field is now optional - apparently that is not a required field in BSM (doesn't really makes sense but okay...)
                
                if let field = gamescore.field {
                    HStack {
                        Image(systemName: "diamond.fill") //this really needs a custom icon
                        Text(String(field.name))
                    }
                    .padding(ScoresItemPadding)
                    HStack {
                        Image(systemName: "house.fill")
                        Text(field.street + ",\n" + field.postal_code + " " + field.city)
                    }
                    .padding(ScoresItemPadding)
                } else {
                    HStack {
                        Image(systemName: "diamond.fill")
                        Text("No location/field data")
                    }
                }
                
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
                
                //start umpire assignments. I support up to four slots, the first two get else statements if empty.
                
                if gamescore.umpire_assignments.indices.contains(0) {
                    HStack {
                        Image(systemName: "person.fill")
                        Text(gamescore.umpire_assignments[0].license.person.last_name + ", " + gamescore.umpire_assignments[0].license.person.first_name)
                        Spacer()
                        Text(gamescore.umpire_assignments[0].license.number)
                            .font(.caption)
                    }.padding(ScoresItemPadding)
                } else {
                    HStack {
                        Image(systemName: "person.fill")
                        Text("No first umpire assigned yet")
                        Spacer()
                    }.padding(ScoresItemPadding)
                }
                
                if gamescore.umpire_assignments.indices.contains(1) {
                    HStack {
                        Image(systemName: "person.fill")
                        Text(gamescore.umpire_assignments[1].license.person.last_name + ", " + gamescore.umpire_assignments[1].license.person.first_name)
                        Spacer()
                        Text(gamescore.umpire_assignments[1].license.number)
                            .font(.caption)
                    }.padding(ScoresItemPadding)
                } else {
                    HStack {
                        Image(systemName: "person.fill")
                        Text("No second umpire assigned yet")
                        Spacer()
                    }.padding(ScoresItemPadding)
                }
                
                if gamescore.umpire_assignments.indices.contains(2) {
                    HStack {
                        Image(systemName: "person.fill")
                        Text(gamescore.umpire_assignments[2].license.person.last_name + ", " + gamescore.umpire_assignments[2].license.person.first_name)
                        Spacer()
                        Text(gamescore.umpire_assignments[2].license.number)
                            .font(.caption)
                    }.padding(ScoresItemPadding)
                }
                
                if gamescore.umpire_assignments.indices.contains(3) {
                    HStack {
                        Image(systemName: "person.fill")
                        Text(gamescore.umpire_assignments[3].license.person.last_name + ", " + gamescore.umpire_assignments[3].license.person.first_name)
                        Spacer()
                        Text(gamescore.umpire_assignments[3].license.number)
                            .font(.caption)
                    }.padding(ScoresItemPadding)
                }
                
                //scorer assignments. I support two entries here to account for double scoring. Only the first one gets an else statement since second scorers are rare
                
                if gamescore.scorer_assignments.indices.contains(0) {
                    HStack {
                        Image(systemName: "pencil")
                        Text(gamescore.scorer_assignments[0].license.person.last_name + ", " + gamescore.scorer_assignments[0].license.person.first_name)
                        Spacer()
                        Text(gamescore.scorer_assignments[0].license.number)
                                .font(.caption)
                    }.padding(ScoresItemPadding)
                } else {
                    HStack {
                        Image(systemName: "pencil")
                        Text("No scorer assigned yet")
                        Spacer()
                    }.padding(ScoresItemPadding)
                }
                
                if gamescore.scorer_assignments.indices.contains(1) {
                    HStack {
                        Image(systemName: "pencil")
                        Text(gamescore.scorer_assignments[1].license.person.last_name + ", " + gamescore.scorer_assignments[1].license.person.first_name)
                        Spacer()
                        Text(gamescore.scorer_assignments[1].license.number)
                                .font(.caption)
                    }.padding(ScoresItemPadding)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Game Details")
    }
}

struct ScoresDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ScoresDetailView(gamescore: dummyGameScores[6])
    }
}
