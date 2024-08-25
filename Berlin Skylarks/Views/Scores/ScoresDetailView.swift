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
    
#if !os(watchOS)
    @EnvironmentObject var calendarManager: CalendarManager
#endif
    
    @State private var showingSheet = false
    @State private var showCalendarDialog = false
    @State private var isBookmarked = false
    @State private var showEventAlert = false
    @State private var showAlertNoGames = false
    @State private var showAlertNoAccess = false
    
    @State var showCalendarChooser = false
    @State private var calendar: EKCalendar?
    
#if !os(watchOS)
    
    func checkAccess() async {
        switch EKEventStore.authorizationStatus(for: .event) {
        case .denied, .restricted:
            showAlertNoAccess = true
        case .writeOnly, .fullAccess:
            showCalendarDialog = true
        default:
            let granted = await calendarManager.requestAccess()
            if granted {
                showCalendarDialog = true
            }
        }
    }
    
    func saveEvent() async {
        let gameDate = getDatefromBSMString(gamescore: gamescore)
        await calendarManager.addGameToCalendar(gameDate: gameDate, gamescore: gamescore, calendar: calendar)
        showEventAlert = true
    }
#endif
    
    var gamescore: GameScore
    
    var body: some View {
        let logos = TeamImageData.fetchCorrectLogos(gamescore: gamescore)
        
        #if !os(watchOS)
        List {
            Section(header: Text("Main info")) {
                ScoreMainInfo(gamescore: gamescore)
            }
            .textSelection(.enabled)
            Section(header: Text("Score")) {
                VStack {
                    //extracted to subview to be used by OverView as well
                    GameResultIndicator(gamescore: gamescore)
                        .font(.title)
                    
                    HStack {
                        VStack {
                            Text("Road", comment: "reference to the road team")
                                .bold()
                            logos.road
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50, alignment: .center)
                            Text(gamescore.away_team_name)
                            //.frame(width: teamNameFrame)
                                .lineLimit(nil)
                        }
                        Spacer()
                        VStack {
                            Text("Home", comment: "Reference to the home team")
                                .bold()
                            logos.home
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
                        if let awayScore = gamescore.away_runs, let homeScore = gamescore.home_runs {
                            Text(String(awayScore))
                                .font(.largeTitle)
                                .bold()
                                .padding(ScoresNumberPadding)
                                .foregroundColor(awayScore < homeScore ? Color.secondary : Color.primary)
                        }
                        Spacer()
                        if let awayScore = gamescore.away_runs, let homeScore = gamescore.home_runs {
                            Text(String(homeScore))
                                .font(.largeTitle)
                                .bold()
                                .padding(ScoresNumberPadding)
                                .foregroundColor(awayScore > homeScore ? Color.secondary : Color.primary)
                        }
                    }
                    .padding(ScoresItemPadding)
                }
            }
            Section(header: Text("Location")) {
                //field is now optional - apparently that is not a required field in BSM (doesn't really make sense but okay...)
                BallparkLocation(gamescore: gamescore)
            }
            .textSelection(.enabled)
            Section(header: Text("Status")) {
                ScoresStatusSection(gamescore: gamescore)
            }
            Section(header: Text("Game officials")) {
                UmpireAssignments(gamescore: gamescore)
                
                //scorer assignments. I support two entries here to account for double scoring. Only the first one gets an else statement since second scorers are rare
                
                ScorerAssignments(gamescore: gamescore)
            }
            .textSelection(.enabled)
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Game Details")
        
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Spacer()
                
                Button(
                    action: {
                        Task {
                            await checkAccess()
                        }
                    }
                ){
                    Image(systemName: "calendar.badge.plus")
                }
                .sheet(isPresented: $showCalendarDialog) {
                    Form {
                        Section {
                            HStack {
                                Spacer()
                                Button("Select Calendar to save to") {
                                    showCalendarChooser.toggle()
                                }
                                .buttonStyle(.bordered)
                                .padding(.vertical)
                                Spacer()
                            }
                            HStack {
                                Spacer()
                                Text("Selected Calendar:")
                                Text(calendar?.title ?? String(localized: "Default"))
                                Spacer()
                            }
                        }
                        Section {
                            HStack {
                                Spacer()
                                Button("Save game data") {
                                    showCalendarDialog = false
                                    Task {
                                        await saveEvent()
                                    }
                                }
                                .buttonStyle(.borderedProminent)
                                .padding(.vertical)
                                Spacer()
                            }
                        }
                    }
                    .presentationDetents([.medium])
                    
                    .sheet(isPresented: $showCalendarChooser) {
                        CalendarChooser(calendar: $calendar)
                    }
                }
                .alert("Save to calendar", isPresented: $showEventAlert) {
                    Button("OK") { }
                } message: {
                    Text("Game has been saved to calendar")
                }
                
                .alert("No access to calendar", isPresented: $showAlertNoAccess) {
                    Button("OK") { }
                } message: {
                    Text("You have disabled access to your calendar. To save games please go to your device settings to enable it.")
                }
                
                Spacer()
                
                let shareItem = createShareGameData()
                ShareLink(item: shareItem)
            }
        }
        
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
                        logos.road
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 30, alignment: .center)
                        Text(gamescore.away_league_entry.team.short_name)
                            .font(.caption)
                            .padding(.leading)
                        Spacer()
                        if let awayScore = gamescore.away_runs, let homeScore = gamescore.home_runs {
                            Text(String(awayScore))
                                .font(.title3)
                                .bold()
                                .frame(maxWidth: 40, alignment: .center)
                                .foregroundColor(awayScore < homeScore ? Color.secondary : Color.primary)
                        }
                    }
                    HStack {
                        logos.home
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 30, alignment: .center)
                        Text(gamescore.home_league_entry.team.short_name)
                            .font(.caption)
                            .padding(.leading)
                        Spacer()
                        if let awayScore = gamescore.away_runs, let homeScore = gamescore.home_runs {
                            Text(String(homeScore))
                                .font(.title3)
                                .bold()
                                .frame(maxWidth: 40, alignment: .center)
                                .foregroundColor(awayScore > homeScore ? Color.secondary : Color.primary)
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
        #endif
    }
    
    #if !os(watchOS)
    func createShareGameData() -> String {
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
            
        //TODO: localise
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
        
        return data
    }
    #endif
}

struct ScoresDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ScoresDetailView(gamescore: dummyGameScores[3])
            //.previewDevice(PreviewDevice(rawValue: "Apple Watch Series 6 - 44mm"))
    }
}
