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
    
    @EnvironmentObject var calendarManager: CalendarManager
    
    @State private var showingSheet = false
    @State private var showCalendarDialog = false
    @State private var isBookmarked = false
    @State private var showEventAlert = false
    @State private var showAlertNoGames = false
    @State private var showAlertNoAccess = false
    
    @State private var calendarTitles = [String]()
    
    @State var roadLogo = away_team_logo
    @State var homeLogo = home_team_logo
    
    func setLogos() {
        let logos = fetchCorrectLogos(gamescore: gamescore)
        roadLogo = logos.road
        homeLogo = logos.home
    }
    
#if !os(watchOS)
    
    func checkAccess() async {
        await calendarManager.calendarAccess = calendarManager.checkAuthorizationStatus()
        if EKEventStore.authorizationStatus(for: .event) == .restricted || EKEventStore.authorizationStatus(for: .event) == .denied {
            showAlertNoAccess = true
        }
        await getCalendars()
    }
    
    func getCalendars() async {
        calendarTitles = []
        await calendarTitles = calendarManager.getAvailableCalendars()
        
        if !calendarTitles.isEmpty {
            showCalendarDialog = true
        } else {
            print("No calendar data")
        }
    }
    
    func saveEvent(calendarTitle: String) {
        let gameDate = getDatefromBSMString(gamescore: gamescore)
        calendarManager.addGameToCalendar(gameDate: gameDate, gamescore: gamescore, calendarTitle: calendarTitle)
        showEventAlert = true
    }
#endif
    
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
                        .font(.title)
                    
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
                
                //MARK: bookmarks
//                Button(action: {
//                    isBookmarked.toggle()
//                    //TODO: actually do stuff here
//                }, label: {
//                    //the button changes its appearance if a bookmark is set
//                    Image(systemName: isBookmarked == true ? "bookmark.fill" : "bookmark")
//                })
                
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
                .confirmationDialog("Choose a calendar to save the game", isPresented: $showCalendarDialog, titleVisibility: .visible) {
                    
                    ForEach(calendarTitles, id: \.self) { calendarTitle in
                        Button(calendarTitle) {
                            saveEvent(calendarTitle: calendarTitle)
                        }
                    }
                }
                .alert("Save to calendar", isPresented: $showEventAlert) {
                    Button("OK") { }
                } message: {
                    Text("Game has been saved to calendar")
                }
                
                .padding(.horizontal, 10)
                
                .alert("No access to calendar", isPresented: $showAlertNoAccess) {
                    Button("OK") { }
                } message: {
                    Text("You have disabled access to your calendar. To save games please go to your device settings to enable it.")
                }
                .padding(.horizontal, 10)
                
                Spacer()
                
                Button(action: {
                    shareGameSheet()
                    
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
                        if let awayScore = gamescore.away_runs, let homeScore = gamescore.home_runs {
                            Text(String(awayScore))
                                .font(.title3)
                                .bold()
                                .frame(maxWidth: 40, alignment: .center)
                                .foregroundColor(awayScore < homeScore ? Color.secondary : Color.primary)
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
        
        .onAppear(perform: {
            setLogos()
        })
        #endif
    }
    #if !os(watchOS)
    
    func shareGameSheet() {
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
        
        //TODO: this works, but it's UIKit, it's an absolute performance nightmare. Refactor me as soon as native share sheet support is in SwiftUI!
        
        let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        if let vc = UIApplication.shared.windows.first?.rootViewController {
            av.popoverPresentationController?.sourceView = vc.view
            //Setup share activity position on screen on bottom center
            av.popoverPresentationController?.sourceRect = CGRect(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
            av.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.right
            vc.present(av, animated: true, completion: nil)
            //UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
        }
    }
    #endif
}

struct ScoresDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ScoresDetailView(gamescore: dummyGameScores[7])
            //.previewDevice(PreviewDevice(rawValue: "Apple Watch Series 6 - 44mm"))
    }
}
