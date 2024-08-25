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
    
#if !os(watchOS)
    @EnvironmentObject var calendarManager: CalendarManager
#endif
    
    @EnvironmentObject var networkManager: NetworkManager
    
    @State private var showAlertNoNetwork = false
    
    @State private var gamescores = [GameScore]()
    @State private var leagueGroups = [LeagueGroup]()
    
    @State private var searchResults = [GameScore]()
    
    @State private var skylarksGamescores = [GameScore]()
    
    @State var showCalendarChooser = false
    @State private var calendar: EKCalendar?
    
    var listData: [GameScore] {
        if showOtherTeams == false && searchText.isEmpty {
            return skylarksGamescores
        } else if showOtherTeams == false && !searchText.isEmpty {
            return searchResults //should always be the correct filter
        } else if showOtherTeams == true && searchText.isEmpty {
            return gamescores
        } else if showOtherTeams == true && !searchText.isEmpty {
            return searchResults
        }
        //fallback, should never be executed
        return gamescores
    }
    
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
        var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue.capitalized) }
        var id: String { self.rawValue }
    }
    
    //TODO: localise
    @State var selectedTeam = "All Teams"
    @State var selectedTeamID: Int = 0 // this is in fact a league ID now - TODO: rename me
    @State var selectedTimeframe = Gameday.current

    @State var filterTeams = ["All Teams", ]
    
    //---------------------------------------------------------//
    //-----------local funcs-----------------------------------//
    //---------------------------------------------------------//
    
    func loadLeagueGroups() async {
        //reset filter options to default
        filterTeams = ["All Teams", ]
        
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
        
        //if we're not filtering by any league, then we do not use the URL parameter at all
        if selectedTeam == "All Teams" {
            gameURLSelected = URL(string: "https://bsm.baseball-softball.de/clubs/\(skylarksID)/matches.json?filters[seasons][]=\(selectedSeason)&filters[gamedays][]=\(selectedTimeframe.rawValue)&api_key=\(apiKey)")!
        }
        //in any other case we filter the API request by league ID
        else {
            gameURLSelected = URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=\(selectedSeason)&filters[leagues][]=\(selectedTeamID)&filters[gamedays][]=\(selectedTimeframe.rawValue)&api_key=\(apiKey)")!
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
        
        //set up separate object for just Skylarks games
        skylarksGamescores = gamescores.filter({ gamescore in
            gamescore.home_team_name.contains("Skylarks") || gamescore.away_team_name.contains("Skylarks")
        })
        
        loadingInProgress = false
    }
    
    func setTeamID() async {
        //set it back to 0 to make sure it does not keep the former value
        selectedTeamID = 0
        for leagueGroup in leagueGroups where leagueGroup.name == selectedTeam {
            selectedTeamID = leagueGroup.id
        }
    }
    
    //---------------------------------------------------------//
    //-------------------func shortcuts------------------------//
    //---------------------------------------------------------//
    
    func refresh() async {
        gamescores = []
        scoresLoaded = false
        await loadGamesAndProcess()
    }
    
    func initialLoad() {
        if gamescores.isEmpty && scoresLoaded == false {
            Task {
                await loadLeagueGroups()
            }
            scoresLoaded = true
        }
    }
    
    func teamChanged() {
        gamescores = []
        scoresLoaded = false
        Task {
            await setTeamID()
            await loadGamesAndProcess()
        }
    }
    
    func timeframeChanged() {
        gamescores = []
        scoresLoaded = false
        Task {
            await loadGamesAndProcess()
        }
    }
    
    func seasonChanged() {
        gamescores = []
        skylarksGamescores = []
        scoresLoaded = false
    }
    
    //---------------------------------------------------------//
    //-------------------calendar funcs------------------------//
    //---------------------------------------------------------//
    
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
    
    func saveEvents() async {
        let scoresToUse = showOtherTeams ? gamescores : skylarksGamescores
        
        for gamescore in scoresToUse {
            let gameDate = getDatefromBSMString(gamescore: gamescore)
            
            await calendarManager.addGameToCalendar(gameDate: gameDate, gamescore: gamescore, calendar: calendar)
            showEventAlert = true
        }
    }
    
#endif
    
    //---------------------------------------------------------//
    //-------------------iOS/macOS view------------------------//
    //---------------------------------------------------------//
    
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
                            Text(gameday.localizedName)
                            .tag(gameday)
                        }
                        
                })
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.vertical, 3)
                List {
                    Section(header: Text("Selected Season: ") + Text(String(selectedSeason))){
                        
                        //Switch to external games/only our games
                        Toggle(String(localized: "Show non-Skylarks Games", comment: "toggle in ScoresView"), isOn: $showOtherTeams)
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
                        if gamescores.isEmpty && loadingInProgress == false {
                            Text("There are no games scheduled for the chosen time frame.")
                        }
                        //convoluted conditions, basically just means: we show just our games, there are none, but there are others that have been filtered out
                        if skylarksGamescores == [] && !gamescores.isEmpty && showOtherTeams == false && loadingInProgress == false {
                            Text("There are no Skylarks games scheduled for the chosen time frame.")
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .animation(.default, value: searchText)
                .animation(.default, value: gamescores)
                .animation(.default, value: showOtherTeams)
                
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: Text("Filter")) //it doesn't let me change the prompt
               
                .onChange(of: searchText) {
                    let searchedObjects = showOtherTeams ? gamescores : skylarksGamescores
                    searchResults = searchedObjects.filter({ gamescore in
                        
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
                    await refresh()
                }
                .onAppear {
                    initialLoad()
                }
                
                .onChange(of: selectedTeam) {
                    teamChanged()
                }
                
                .onChange(of: selectedTimeframe) {
                    timeframeChanged()
                }
                
                .onChange(of: selectedSeason) {
                    seasonChanged()
                }
                
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
                                                await saveEvents()
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
                    
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Picker(
                            selection: $selectedTeam,
                            //this actually does not show the label, just the selection
                            label: HStack {
                                //Text(selectedTeam)
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
            Section(header: Text("Selected Season: ") + Text(String(selectedSeason))) {
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
                            Text(gameday.localizedName)
                            .tag(gameday)
                        }
                })
                Toggle("Show non-Skylarks Games", isOn: $showOtherTeams)
                    .tint(.skylarksRed)
                ForEach(listData, id: \.id) { GameScore in
                    NavigationLink(destination: ScoresDetailView(gamescore: GameScore)) {
                        ScoresOverView(gamescore: GameScore)
                    }
                    .foregroundColor(.primary)
                }
                if gamescores.isEmpty && loadingInProgress == false {
                    Text("There are no games scheduled for the chosen time frame.")
                        .font(.caption2)
                        .padding()
                }
            }
        }
        .animation(.default, value: gamescores)
        .animation(.default, value: showOtherTeams)
        .navigationTitle("Scores")
        
        //APPLE WATCH SEPARATE FUNCS/////////////////////////////////////////////////////////////////////
        
        .refreshable {
            await refresh()
        }
        .onAppear(perform: {
            initialLoad()
        })
        
        .onChange(of: selectedTeam) {
            teamChanged()
        }
        
        .onChange(of: selectedTimeframe) {
            timeframeChanged()
        }
        
        .onChange(of: selectedSeason) {
            seasonChanged()
        }
        
        #endif
    }
}

struct ScoresView_Previews: PreviewProvider {
    static var previews: some View {
            ScoresView()
                //.preferredColorScheme(.dark)
#if !os(watchOS)
                .environmentObject(CalendarManager())
#endif
    }
}
