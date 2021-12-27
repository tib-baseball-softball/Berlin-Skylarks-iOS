//
//  ScoresDetailView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 27.12.20.
//

import SwiftUI
import MapKit
import EventKit

struct ScoresDetailView: View {
    
    @State private var showingSheet = false
    @State private var showCalendarDialog = false
    @State private var isBookmarked = false
    @State private var showEventAlert = false
    
    //let calendars = getAvailableCalendars()
    
    var gamescore: GameScore
    
    var body: some View {
        #if !os(watchOS)
        setCorrectLogo(gamescore: gamescore)
        gameDate = getDatefromBSMString(gamescore: gamescore)
        determineGameStatus(gamescore: gamescore)
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
                    if gamescore.human_state.contains("geplant") {
                        Text("TBD")
                            .font(.title)
                            .bold()
                            .padding(ScoresItemPadding)
                    }
                    if gamescore.human_state.contains("ausgefallen") {
                        Text("PPD")
                            .font(.title)
                            .bold()
                            .padding(ScoresItemPadding)
                    }
                    if gamescore.human_state.contains("gespielt") {
                        if !isDerby {
                            if skylarksWin {
                                Text("W")
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(Color.green)
                                    .padding(ScoresItemPadding)
                            } else {
                                Text("L")
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(Color.accentColor)
                                    .padding(ScoresItemPadding)
                            }
                        } else {
                            VStack {
                                Image(systemName: "heart.fill")
                                    .font(.title)
                                    .foregroundColor(Color.accentColor)
                                Text("Derby - Skylarks win either way")
                                    .padding(ScoresItemPadding)
                            }
                            .padding(ScoresItemPadding)
                        }
                    }
                    HStack {
                        VStack {
                            Text("Guest")
                                .bold()
                            away_team_logo
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
                            home_team_logo
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50, alignment: .center)
                            Text(gamescore.home_team_name)
                                //.frame(width: teamNameFrame)
                                .lineLimit(nil)
                        }.frame(width: teamNameFrame)
                    }
                    .padding(ScoresItemPadding)
                    Divider()
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
                
                //field is now optional - apparently that is not a required field in BSM (doesn't really make sense but okay...)
                
                if let field = gamescore.field {
                    if let coordinateLatitude = field.latitude, let coordinateLongitude = field.longitude {
                        let fieldPin = [
                            Ballpark(name: field.name, coordinate: CLLocationCoordinate2D(latitude: coordinateLatitude, longitude: coordinateLongitude)),
                            ]
                        Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: coordinateLatitude, longitude: coordinateLongitude), span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015))), interactionModes: .zoom, annotationItems: fieldPin) {
                                MapMarker(coordinate: $0.coordinate, tint: Color.accentColor)
                        }
                        .frame(height: 200)
                        
                        //TODO: make this a link to open the maps app
//                        .onTapGesture(perform: {
//                            map.openInMaps()
//                        })
                        
                    } else {
                        Text("No field coordinates provided")
                    }
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
                
                if let scoresheetURL = gamescore.scoresheet_url {
                    HStack {
                        Image(systemName: "doc.fill")
                        Link("Link to Scoresheet", destination: URL(string: scoresheetURL)!)
                    }
                    .padding(ScoresItemPadding)
                } else {
                    HStack {
                        Image(systemName: "doc.fill")
                        Text("Scoresheet unavailable")
                    }
                    .padding(ScoresItemPadding)
                }
                
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
        
        .listStyle(.insetGrouped)
        .navigationTitle("Game Details")
        
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    isBookmarked.toggle()
                    
                }, label: {
                    //the button changes its appearance if a bookmark is set
                    Image(systemName: isBookmarked == true ? "bookmark.fill" : "bookmark")
                })
                
                Spacer()
                
                Button(
                    action: {
                        getAvailableCalendars()
                        showCalendarDialog.toggle()
                    }
                ){
                    Image(systemName: "calendar.badge.plus")
                }
                .confirmationDialog("Choose a calendar to save the game", isPresented: $showCalendarDialog, titleVisibility: .visible) {
                    
                    ForEach(calendarStrings, id: \.self) { calendarString in
                        Button(calendarString) {
                            //gameDate = getDatefromBSMString(gamescore: gamescore)
                            let localGameDate = getDatefromBSMString(gamescore: gamescore)
                            addGameToCalendar(gameDate: localGameDate, gamescore: gamescore, calendarString: calendarString)
                            showEventAlert = true
                            
                        }
                    }
                }
                .alert("Game has been saved to calendar", isPresented: $showEventAlert) {
                    Button("OK") { }
                }
                
                Spacer()
                
                Button(action: {
                    //showingSheet.toggle()
                    ActionSheet()
                    
                }, label: {
                    Image(systemName: "square.and.arrow.up")
                })
//                .sheet(isPresented: $showingSheet) {
//                    ShareSheet()
//                }
            }
//            ToolbarItem(placement: .principal) {
//                Button(action: {
//                    print("doc button pressed")
//
//                }, label: {
//                    Image(systemName: "doc.on.doc")
//                })
//            }
        }
        #endif
        
        #if os(watchOS)
        Text("Detailed info here")
        #endif
    }
    #if !os(watchOS)
    //TODO: this works, but is an absolute performance nightmare and leads to boatloads of errors in console
    
    func ActionSheet() {
        let data = "League: "
        + gamescore.league.name
        + """
        
        
        """
        + "Match Number: "
        + gamescore.match_id
        let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
    #endif
}

struct ScoresDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ScoresDetailView(gamescore: dummyGameScores[47])
            //.previewDevice(PreviewDevice(rawValue: "Apple Watch Series 6 - 44mm"))
    }
}
