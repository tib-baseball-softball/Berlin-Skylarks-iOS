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
    
    @State var roadLogo = away_team_logo
    @State var homeLogo = home_team_logo
    
    func setLogos() {
        let logos = fetchCorrectLogos(gamescore: gamescore)
        roadLogo = logos.road
        homeLogo = logos.home
    }
    
    var gamescore: GameScore
    
    var body: some View {
        #if !os(watchOS)
        List {
            Section(header: Text("Main info")) {
                ScoreMainInfo(gamescore: gamescore)
            }
            Section(header: Text("Score")) {
                VStack {
                    //extracted to subview to be used by OverView as well
                    GameResultIndicator(gamescore: gamescore)
                    
                    HStack {
                        VStack {
                            Text("Guest")
                                .bold()
                            roadLogo
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
                            homeLogo
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
                
                BallparkLocation(gamescore: gamescore)
            }
            Section(header: Text("Status")) {
                
                ScoresStatusSection(gamescore: gamescore)
            }
            Section(header: Text("Game officials")) {
                
                //start umpire assignments.
                
                UmpireAssignments(gamescore: gamescore)
                
                //scorer assignments. I support two entries here to account for double scoring. Only the first one gets an else statement since second scorers are rare
                
                ScorerAssignments(gamescore: gamescore)
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Game Details")
        
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    isBookmarked.toggle()
                    //TODO: actually do stuff here
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
                .alert("Save to calendar", isPresented: $showEventAlert) {
                    Button("OK") { }
                } message: {
                    Text("Game has been saved to calendar")
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
        .onAppear(perform: {
            setLogos()
        })
        
        #endif
        
        //---------------------------------------------------------//
        //-----------start Apple Watch-specific code---------------//
        //---------------------------------------------------------//
        
        #if os(watchOS)
        List {
            Section(header: Text("Main info")) {
                ScoreMainInfo(gamescore: gamescore)
            }
            Section(header: Text("Score")) {
                VStack {
                    HStack {
                        roadLogo
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 30, alignment: .center)
                        Text(gamescore.away_league_entry.team.short_name)
                            .font(.caption)
                            .padding(.leading)
                        Spacer()
                        if let awayScore = gamescore.away_runs {
                            Text(String(awayScore))
                                .font(.title3)
                                .bold()
                                .frame(maxWidth: 40, alignment: .center)
                                .foregroundColor(gamescore.away_team_name.contains("Skylarks") ? Color.accentColor : Color.primary)
                        }
                    }
                    HStack {
                        homeLogo
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 30, alignment: .center)
                        Text(gamescore.home_league_entry.team.short_name)
                            .font(.caption)
                            .padding(.leading)
                        Spacer()
                        if let homeScore = gamescore.home_runs {
                            Text(String(homeScore))
                                .font(.title3)
                                .bold()
                                .frame(maxWidth: 40, alignment: .center)
                                .foregroundColor(gamescore.home_team_name.contains("Skylarks") ? Color.accentColor : Color.primary)
                        }
                    }
                }
                .padding(.vertical)
                ScoresStatusSection(gamescore: gamescore)
                    .font(.caption)
            }
            Section(header: Text("Location")) {
                
                BallparkLocation(gamescore: gamescore)
                    .font(.caption)
            }
            Section(header: Text("Game officials")) {
                
                //start umpire assignments.
                
                UmpireAssignments(gamescore: gamescore)
                    .font(.caption)
                
                //scorer assignments. I support two entries here to account for double scoring. Only the first one gets an else statement since second scorers are rare
                
                ScorerAssignments(gamescore: gamescore)
                    .font(.caption)
            }
        }
        .listStyle(.automatic)
        .navigationTitle("Game Details")
        
        .onAppear(perform: {
            setLogos()
        })
        #endif
    }
    #if !os(watchOS)
    
    //TODO: this works, but it's UIKit, it's an absolute performance nightmare
    
    func ActionSheet() {
        let formatter1 = DateFormatter()
        let formatter2 = DateFormatter()
        formatter1.dateStyle = .short
        formatter2.timeStyle = .short
        
        var date: String = "date"
        var time: String = "time"
        
        if let gameDate = gamescore.gameDate {
            date = formatter1.string(from: gameDate)
            time = formatter2.string(from: gameDate)
        }
            
        let data = """
        Game data - sent from Skylarks app
        
        League: \(gamescore.league.name)
        Match Number: \(gamescore.match_id)
        Date: \(date)
        Time: \(time)
        
        Status: \(gamescore.human_state)
        Road Team: \(gamescore.away_team_name) - \(gamescore.away_runs ?? 0)
        Home Team: \(gamescore.home_team_name) - \(gamescore.home_runs ?? 0)
        
        Field: \(gamescore.field?.name ?? "No data")
        Address: \(gamescore.field?.street ?? ""), \(gamescore.field?.postal_code ?? "") \(gamescore.field?.city ?? "")
        
        Link to Scoresheet: \(gamescore.scoresheet_url ?? "Not available yet")
        """
        
        let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
    #endif
}

struct ScoreMainInfo: View {
    
    var gamescore: GameScore
    
    var body: some View {
        HStack {
            Image(systemName: "list.bullet")
            Text(gamescore.league.name)
        }.padding(ScoresItemPadding)
        HStack {
            Image(systemName: "number")
            Text("\(gamescore.match_id)")
        }
        .padding(ScoresItemPadding)
        if let gameDate = gamescore.gameDate {
            HStack {
                Image(systemName: "calendar")
                Text(gameDate, style: .date)
            }
            .padding(ScoresItemPadding)
        }
        if let gameDate = gamescore.gameDate {
            HStack {
                Image(systemName: "clock.fill")
                Text(gameDate, style: .time)
            }
            .padding(ScoresItemPadding)
        }
    }
}

struct GameResultIndicator: View {
    
    var gamescore: GameScore
    
    var body: some View {
        if gamescore.human_state.contains("geplant") {
            Text("TBD")
                .font(.title)
                .bold()
                .padding()
        }
        if gamescore.human_state.contains("ausgefallen") {
            Text("PPD")
                .font(.title)
                .bold()
                .padding()
        }
        if let derby = gamescore.isDerby, let win = gamescore.skylarksWin {
            if gamescore.human_state.contains("gespielt") ||
                gamescore.human_state.contains("Forfeit") ||
                gamescore.human_state.contains("Nichtantreten") ||
                gamescore.human_state.contains("Wertung") ||
                gamescore.human_state.contains("Rückzug") ||
                gamescore.human_state.contains("Ausschluss") {
                if !derby {
                    if win {
                        Text("W")
                            .font(.title)
                            .bold()
                            .foregroundColor(Color.green)
                            .padding()
                    } else {
                        Text("L")
                            .font(.title)
                            .bold()
                            .foregroundColor(Color.accentColor)
                            .padding()
                    }
                } else {
                    VStack {
                        Image(systemName: "heart.fill")
                            .font(.title)
                            .foregroundColor(Color.accentColor)
                        Text("Derby - Skylarks win either way")
                            .padding()
                    }
                    .padding()
                }
            }
        }
    }
}

struct ScoresStatusSection: View {
    var gamescore: GameScore
    
    var body: some View {
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
}

struct UmpireAssignments: View {
    
    var gamescore: GameScore
    
    var body: some View {
        ForEach(gamescore.umpire_assignments, id: \.self) { umpireEntry in
            HStack {
                Image(systemName: "person.fill")
                Text(umpireEntry.license.person.last_name + ", " + umpireEntry.license.person.first_name)
                Spacer()
                Text(umpireEntry.license.number)
                .iOS { $0.font(.caption) }
            }.padding(ScoresItemPadding)
        }
        
        if !gamescore.umpire_assignments.indices.contains(0) {
            HStack {
                Image(systemName: "person.fill")
                Text("No first umpire assigned yet")
                Spacer()
            }.padding(ScoresItemPadding)
        }
        
        if !gamescore.umpire_assignments.indices.contains(1) {
            HStack {
                Image(systemName: "person.fill")
                Text("No second umpire assigned yet")
                Spacer()
            }.padding(ScoresItemPadding)
        }
    }
}

struct ScorerAssignments: View {
    
    var gamescore: GameScore
    
    var body: some View {
        if gamescore.scorer_assignments != [] {
            ForEach(gamescore.scorer_assignments, id: \.self) { scorerEntry in
                HStack {
                    Image(systemName: "pencil")
                    Text(scorerEntry.license.person.last_name + ", " + scorerEntry.license.person.first_name)
                    Spacer()
                    Text(scorerEntry.license.number)
                        .iOS { $0.font(.caption) }
                }.padding(ScoresItemPadding)
            }
        } else {
            HStack {
                Image(systemName: "pencil")
                Text("No scorer assigned yet")
                Spacer()
            }.padding(ScoresItemPadding)
        }
    }
}

struct BallparkLocation: View {
    
    var gamescore: GameScore
    
    var body: some View {
        if let field = gamescore.field {
            if let coordinateLatitude = field.latitude, let coordinateLongitude = field.longitude {
                let fieldPin = [
                    Ballpark(name: field.name, coordinate: CLLocationCoordinate2D(latitude: coordinateLatitude, longitude: coordinateLongitude)),
                    ]
                Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: coordinateLatitude, longitude: coordinateLongitude), span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015))), interactionModes: [], annotationItems: fieldPin) {
                        MapMarker(coordinate: $0.coordinate, tint: Color.accentColor)
                }
                .frame(height: 200)
                
                .onTapGesture(perform: {
                    if !fieldPin.isEmpty {
                        let coordinate = fieldPin[0].coordinate
                        let placemark = MKPlacemark(coordinate: coordinate)
                        let mapItem = MKMapItem(placemark: placemark)
                        mapItem.name = fieldPin[0].name
                        mapItem.openInMaps()
                    }
                })
                
            } else {
                Text("No field coordinates provided")
            }
            HStack {
                Image(systemName: "diamond.fill") //this really needs a custom icon
                Text(String(field.name))
            }
            .padding(ScoresItemPadding)
            HStack {
                Image(systemName: "map")
                if let street = field.street, let postalCode = field.postal_code, let city = field.city {
                    Text(street + ",\n" + postalCode + " " + city)
                }
            }
            .padding(ScoresItemPadding)
        } else {
            HStack {
                Image(systemName: "diamond.fill")
                Text("No location/field data")
            }
        }
    }
}

struct ScoresDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ScoresDetailView(gamescore: dummyGameScores[7])
            //.previewDevice(PreviewDevice(rawValue: "Apple Watch Series 6 - 44mm"))
    }
}
