//
//  ScoresView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 26.12.20.
//

import SwiftUI
import EventKit

struct ScoresView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var calendarManager: CalendarManager
    @EnvironmentObject var networkManager: NetworkManager
    
    @State private var showAlertNoNetwork = false
    
    @State private var gamescores = [GameScore]()
    @State private var leagueGroups = [LeagueGroup]()
    
    @State private var searchResults = [GameScore]()
    
    @State private var calendarTitles = [String]()
    
    var listData: [GameScore] {
        if searchText.isEmpty {
            return gamescores
        } else {
            return searchResults
        }
    }
    
    //@State private var scoresURLs: [String : URL] = [:]
    
    @State private var showCalendarDialog = false
    @State private var showEventAlert = false
    @State private var showAlertNoGames = false
    @State private var showAlertNoAccess = false
    @State private var loadingInProgress = false
    @State private var scoresLoaded = false
    
    @AppStorage("showOtherTeams") var showOtherTeams = false
    
    @State private var searchText = ""
    
    @State private var filterDate = Date()
    
    @AppStorage("selectedSeason") var selectedSeason = Calendar(identifier: .gregorian).dateComponents([.year], from: .now).year!
    
    enum Gameday: String, Identifiable, CaseIterable {
        case previous
        case current
        case next
        case any
        
        var displayName: String { rawValue.capitalized }
        var id: String { self.rawValue }
    }
    
    @State var selectedTeam = "All Teams"
    @State var selectedTeamID: Int = 0 //this is in fact a league ID now
    @State var selectedTimeframe = Gameday.current

    @State var filterTeams = [
        "All Teams",
    ]
    
    func loadLeagueGroups() async {
        //reset filter options to default
        filterTeams = [
            "All Teams",
        ]
        
        let leagueGroupsURL = URL(string:"https://bsm.baseball-softball.de/league_groups.json?filters[seasons][]=" + "\(selectedSeason)" + "&api_key=" + apiKey)!
        
        do {
            leagueGroups = try await fetchBSMData(url: leagueGroupsURL, dataType: [LeagueGroup].self)
        } catch {
            print("Request failed with error: \(error)")
        }
        
        //add teams to filter
        for leagueGroup in leagueGroups {
            filterTeams.append(leagueGroup.name)
        }
        await loadGamesAndProcess()
    }
    
    func loadGamesAndProcess() async {
        if networkManager.isConnected == false {
            showAlertNoNetwork = true
        }
        loadingInProgress = true
        var gameURLSelected: URL? = nil
        
        //check: setting this variable locally now instead of computed property in view
        var skylarksURLFilter = ""
        
        if showOtherTeams == true {
            skylarksURLFilter = ""
        } else {
            skylarksURLFilter = "&search=skylarks"
        }
        
        //if we're not filtering by any league, then we do not use the URL parameter at all
        if selectedTeam == "All Teams" {
            gameURLSelected = URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=" + "\(selectedSeason)" + "\(skylarksURLFilter)" + "&filters[gamedays][]=" + selectedTimeframe.rawValue + "&api_key=" + apiKey)!
            print(gameURLSelected!)
        }
        //in any other case we filter the API request by league ID
        else {
            gameURLSelected = URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=" + "\(selectedSeason)" + "\(skylarksURLFilter)" + "&filters[leagues][]=" + "\(selectedTeamID)" + "&filters[gamedays][]=" + selectedTimeframe.rawValue + "&api_key=" + apiKey)!
            print(gameURLSelected!)
        }
        
        do {
            gamescores = try await fetchBSMData(url: gameURLSelected!, dataType: [GameScore].self)
        } catch {
            print("Request failed with error: \(error)")
        }
        
        for (index, _) in gamescores.enumerated() {
            gamescores[index].addDates()
            gamescores[index].determineGameStatus()
        }
        
        loadingInProgress = false
    }
    
    func setTeamID() async {
        //set it back to 0 to make sure it does not keep the former value
        selectedTeamID = 0
        for leagueGroup in leagueGroups where leagueGroup.name == selectedTeam {
            selectedTeamID = leagueGroup.id
        }
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
        if !gamescores.isEmpty {
            //clear the array before loading the new ones
            calendarTitles = []
            await calendarTitles = calendarManager.getAvailableCalendars()
            
            if !calendarTitles.isEmpty {
                showCalendarDialog = true
            } else {
                print("No calendar data")
            }
        } else {
            showAlertNoGames = true
        }
    }
    
    func saveEvents(calendarTitle: String) {
        for gamescore in gamescores {
            let gameDate = getDatefromBSMString(gamescore: gamescore)
            
            calendarManager.addGameToCalendar(gameDate: gameDate, gamescore: gamescore, calendarTitle: calendarTitle)
            showEventAlert = true
        }
    }
    
#endif
    
    var body: some View {
#if !os(watchOS)
        ZStack {
            Color(colorScheme == .light ? .secondarySystemBackground : .systemBackground)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Picker(
                    selection: $selectedTimeframe,
                    //this actually does not show the label, just the selection
                    label: HStack {
                        Text("Show:")
                        //Text(selection)
                    },
                    content: {
                        ForEach(Gameday.allCases) { gameday in
                            Text(gameday.displayName)
                            .tag(gameday)
                        }
                        
                })
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.vertical, 3)
                List {
                    Section(header: Text("Selected Season: " + String(selectedSeason))){
                        
                        //Switch to external games/only our games
                        Toggle("Show non-Skylarks Games", isOn: $showOtherTeams)
                            .tint(.skylarksRed)
                        
                        //Loading in progress
                        if loadingInProgress == true {
                            LoadingView()
                        }
                        
                        //the actual game data
                        ForEach(listData, id: \.id) { GameScore in
                            NavigationLink(destination: ScoresDetailView(gamescore: GameScore)) {
                                ScoresOverView(gamescore: GameScore)
                            }
                            .foregroundColor(.primary)
                            .listRowSeparatorTint(.skylarksRed)
                        }
                        
                        //fallback if there are no games
                        if gamescores == [] && loadingInProgress == false {
                            Text("There are no games scheduled for the chosen time frame.")
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .animation(.default, value: searchText)
                .animation(.default, value: gamescores)
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: Text("Filter")) //it doesn't let me change the prompt
               
                .onChange(of: searchText) { searchText in
                    searchResults = self.gamescores.filter({ gamescore in
                        
                        // list all fields that are searched
                        gamescore.home_team_name.lowercased().contains(searchText.lowercased()) ||
                        gamescore.away_team_name.lowercased().contains(searchText.lowercased()) ||
                        gamescore.match_id.lowercased().contains(searchText.lowercased()) ||
                        gamescore.league.name.lowercased().contains(searchText.lowercased()) ||
                        //MARK: watch for index errors here
                        gamescore.home_league_entry.team.clubs[0].name.lowercased().contains(searchText.lowercased()) ||
                        gamescore.away_league_entry.team.clubs[0].name.lowercased().contains(searchText.lowercased()) ||
                        gamescore.home_league_entry.team.clubs[0].short_name.lowercased().contains(searchText.lowercased()) ||
                        gamescore.away_league_entry.team.clubs[0].short_name.lowercased().contains(searchText.lowercased()) ||
                        gamescore.home_league_entry.team.clubs[0].acronym.lowercased().contains(searchText.lowercased()) ||
                        gamescore.away_league_entry.team.clubs[0].acronym.lowercased().contains(searchText.lowercased())
                    })
                }
                .refreshable {
                    gamescores = []
                    scoresLoaded = false
                    await loadGamesAndProcess()
                }
                .onAppear(perform: {
                    if gamescores.isEmpty && scoresLoaded == false {
                        Task {
                            await loadLeagueGroups()
                        }
                        scoresLoaded = true
                    }
                })
                
                .onChange(of: selectedTeam, perform: { value in
                    gamescores = []
                    scoresLoaded = false
                    Task {
                        await setTeamID()
                        await loadGamesAndProcess()
                    }
                })
                
                .onChange(of: selectedTimeframe, perform: { value in
                    gamescores = []
                    scoresLoaded = false
                    Task {
                        await loadGamesAndProcess()
                    }
                })
                
                .onChange(of: showOtherTeams, perform: { value in
                    gamescores = []
                    scoresLoaded = false
                    Task {
                        await loadGamesAndProcess()
                    }
                })
                
                .onChange(of: selectedSeason, perform: { value in
                    gamescores = []
                    scoresLoaded = false
                    //loadLeagueGroups()
                })
                
                // this is the toolbar with the picker in the top right corner where you can select which games to display.
            
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button(
                            action: {
                                Task {
                                    await checkAccess()
                                }
                            }
                        ){
                            Image(systemName: "calendar.badge.plus")
                        }
                        
                        .confirmationDialog("Choose a calendar to save the game(s)", isPresented: $showCalendarDialog, titleVisibility: .visible) {
                            
                            ForEach(calendarTitles, id: \.self) { calendarTitle in
                                Button(calendarTitle) {
                                    saveEvents(calendarTitle: calendarTitle)
                                }
                            }
                        }
                        
                        .alert("Save to calendar", isPresented: $showEventAlert) {
                            Button("OK") { }
                        } message: {
                            Text("All games have been saved.")
                        }
                        
                        .alert("Save to calendar", isPresented: $showAlertNoGames) {
                            Button("OK") { }
                        } message: {
                            Text("There is no game data to save.")
                        }
                        
                        .alert("No access to calendar", isPresented: $showAlertNoAccess) {
                            Button("OK") { }
                        } message: {
                            Text("You have disabled access to your calendar. To save games please go to your device settings to enable it.")
                        }
                        
                        .alert("No network connection", isPresented: $showAlertNoNetwork) {
                            Button("OK") { }
                        } message: {
                            Text("No active network connection has been detected. The app needs a connection to download its data.")
                        }
                        
                        //Toggle("Show other teams", isOn: $showOtherTeams)
                    }
                    
                    //not sure if I want this
        //            ToolbarItemGroup(placement: .principal) {
        //                DatePicker("Select a specific date", selection: $filterDate, displayedComponents: .date)
        //            }
                    
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Picker(
                            selection: $selectedTeam,
                            //this actually does not show the label, just the selection
                            label: HStack {
                                Text("Show:")
                                //Text(selection)
                            },
                            content: {
                                ForEach(filterTeams, id: \.self) { option in
                                    HStack {
                                        Image(systemName: "person.3")
                                        Text(" " + option)
                                    }
                                    .tag(option)
                                }
                                
                        })
                        .pickerStyle(.menu)
                        .padding(.vertical, scoresGridPadding)
                    }
                }
            .navigationTitle("Scores")
            }
        }
        #endif
        
        //---------------------------------------------------------//
        //-----------start Apple Watch-specific code---------------//
        //---------------------------------------------------------//
        
#if os(watchOS)
        List {
            Section(header: Text("Selected Season: " + String(selectedSeason))) {
                if loadingInProgress == true {
                    LoadingView()
                }
                Picker(
                    selection: $selectedTeam,

                    label: HStack {
                        //                    Image(systemName: "list.bullet.circle")
                        //                        .foregroundColor(.skylarksRed)
                        Text("Team:")
                    },

                    content: {
                        ForEach(filterTeams, id: \.self) { option in
                            HStack {
                                //Image(systemName: "list.bullet.circle")
                                Text(" " + option)
                            }
                            .tag(option)
                        }
                    }
                )
                Picker(
                    selection: $selectedTimeframe,
                    //this actually does not show the label, just the selection
                    label: HStack {
                        Text("Gameday:")
                        //Text(selection)
                    },
                    content: {
                        ForEach(Gameday.allCases) { gameday in
                            Text(gameday.displayName)
                            .tag(gameday)
                        }
                        
                })
                
                ForEach(self.gamescores, id: \.id) { GameScore in
                    NavigationLink(destination: ScoresDetailView(gamescore: GameScore)) {
                        ScoresOverView(gamescore: GameScore)
                    }
                    .foregroundColor(.primary)
                }
                if gamescores.isEmpty && loadingInProgress == false {
                    Text("There are no Skylarks games scheduled for the chosen time frame.")
                        .font(.caption2)
                        .padding()
                }
                Toggle("Show non-Skylarks Games", isOn: $showOtherTeams)
                    .tint(.skylarksRed)
            }
        }
        .animation(.default, value: gamescores)
        .navigationTitle("Scores")
        
        //APPLE WATCH SEPARATE FUNCS/////////////////////////////////////////////////////////////////////
        
        .refreshable {
            gamescores = []
            scoresLoaded = false
            await loadGamesAndProcess()
        }
        .onAppear(perform: {
            if gamescores.isEmpty && scoresLoaded == false {
                Task {
                    await loadLeagueGroups()
                }
                scoresLoaded = true
            }
        })
        
        .onChange(of: selectedTeam, perform: { value in
            gamescores = []
            scoresLoaded = false
            Task {
                await setTeamID()
                await loadGamesAndProcess()
            }
        })
        
        .onChange(of: selectedTimeframe, perform: { value in
            gamescores = []
            scoresLoaded = false
            Task {
                await loadGamesAndProcess()
            }
        })
        
        .onChange(of: showOtherTeams, perform: { value in
            gamescores = []
            scoresLoaded = false
            Task {
                await loadGamesAndProcess()
            }
        })
        
        .onChange(of: selectedSeason, perform: { value in
            gamescores = []
            scoresLoaded = false
            //loadLeagueGroups()
        })
        
        #endif
    }
}

struct ScoresView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScoresView()
                //.preferredColorScheme(.dark)
                .environmentObject(CalendarManager())
        }
    }
}
