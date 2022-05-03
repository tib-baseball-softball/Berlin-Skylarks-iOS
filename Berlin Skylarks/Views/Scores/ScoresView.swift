//
//  ScoresView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 26.12.20.
//

import SwiftUI

struct ScoresView: View {
    
    @State private var gamescores = [GameScore]()
    @State private var leagueGroups = [LeagueGroup]()
    
    //@State var gameData = [GameData]()
    
    @State private var searchResults = [GameScore]()
    
    var listData: [GameScore] {
        if searchText.isEmpty {
            return gamescores
        } else {
            return searchResults
        }
    }
    
    @State private var scoresURLs: [String : URL] = [:]
    
    @State private var showCalendarDialog = false
    @State private var showEventAlert = false
    @State private var showAlertNoGames = false
    @State private var loadingInProgress = false
    
    @State private var searchText = ""
    
    @State var selection = "Current Gameday"
    
    @State private var filterDate = Date()
    
    @AppStorage("selectedSeason") var selectedSeason = Calendar(identifier: .gregorian).dateComponents([.year], from: .now).year!

    @State var filterOptions = [
        "Previous Gameday", "Current Gameday", "Next Gameday", "Full Season"
    ]
    
    //used for previous grid implementation
    let columns = [
        GridItem(.adaptive(minimum: 300), spacing: scoresGridSpacing),
    ]
    
    func loadLeagueGroups() async {
        let leagueGroupsURL = URL(string:"https://bsm.baseball-softball.de/league_groups.json?filters[seasons][]=" + "\(selectedSeason)" + "&api_key=" + apiKey)!
        
        //reset filter options to default
        filterOptions = [
            "Previous Gameday", "Current Gameday", "Next Gameday", "Full Season",
        ]
        
        //old format, club ID is not used anymore - check for errors:
        //URL(string: "https://bsm.baseball-softball.de/clubs/" + skylarksID + "/matches.json?filter[seasons][]=" + "\(selectedSeason)" + "&search=skylarks&filters[gamedays][]=previous&api_key=" + apiKey)!
        
        let urlPreviousGameday = URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=" + "\(selectedSeason)" + "&search=skylarks&filters[gamedays][]=previous&api_key=" + apiKey)!
        let urlCurrentGameday = URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=" + "\(selectedSeason)" + "&search=skylarks&filters[gamedays][]=current&api_key=" + apiKey)!
        let urlNextGameday = URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=" + "\(selectedSeason)" + "&search=skylarks&filters[gamedays][]=next&api_key=" + apiKey)!
        let urlFullSeason = URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=" + "\(selectedSeason)" + "&search=skylarks&filters[gamedays][]=any&api_key=" + apiKey)!

        //provide default values for dict/reset on change of season
        scoresURLs = [
            "Previous Gameday": urlPreviousGameday,
            "Current Gameday": urlCurrentGameday,
            "Next Gameday": urlNextGameday,
            "Full Season": urlFullSeason,
        ]
        
        do {
            leagueGroups = try await fetchBSMData(url: leagueGroupsURL, dataType: [LeagueGroup].self)
        } catch {
            print("Request failed with error: \(error)")
        }
        
        //add leagueGroup IDs to previously created dict using league names as key / add names to filter options for the user to select
        for leagueGroup in leagueGroups {
            filterOptions.append(leagueGroup.name)
            scoresURLs[leagueGroup.name] = URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=" + "\(selectedSeason)" + "&search=skylarks&filters[leagues][]=" + "\(leagueGroup.id)" + "&filters[gamedays][]=any&api_key=" + apiKey)!
        }
        await loadGamesAndProcess()
    }
    
    func loadGamesAndProcess() async {
        for (string, url) in scoresURLs {
            if selection == string {
                let gameURLSelected = url
                loadingInProgress = true
                
                do {
                    gamescores = try await fetchBSMData(url: gameURLSelected, dataType: [GameScore].self)
                } catch {
                    print("Request failed with error: \(error)")
                }
                
                for (index, _) in gamescores.enumerated() {
                    gamescores[index].addDates()
                    gamescores[index].determineGameStatus()
//                    gameData = gamescores.map { (gamescore) -> GameData in
//                        let someData = GameData(gamescore: gamescore)
//                        return someData
//                    }
                }
                
                loadingInProgress = false
            }
        }
    }
    
    var body: some View {
#if !os(watchOS)
        List {
            //Text(gameData.debugDescription)
            if loadingInProgress == true {
                LoadingView()
            }
            ForEach(listData, id: \.id) { GameScore in
                NavigationLink(destination: ScoresDetailView(gamescore: GameScore)) {
                    ScoresOverView(gamescore: GameScore)
                }
                .foregroundColor(.primary)
            }
            if gamescores == [] && loadingInProgress == false {
                Text("There are no Skylarks games scheduled for the chosen time frame.")
            }
        }
        .listStyle(.insetGrouped)
        .animation(.default, value: searchText)
        .animation(.default, value: gamescores)
        .searchable(text: $searchText)
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
            await loadGamesAndProcess()
        }
        .onAppear(perform: {
            if gamescores.isEmpty {
                Task {
                    await loadLeagueGroups()
                }
            }
            getAvailableCalendars()
        })
        
        .onChange(of: selection, perform: { value in
            gamescores = []
            Task {
                await loadGamesAndProcess()
            }
        })
        
        .onChange(of: selectedSeason, perform: { value in
            gamescores = []
            //loadLeagueGroups()
        })
        
        // this is the toolbar with the picker in the top right corner where you can select which games to display.
    
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button(
                    action: {
                        if gamescores != [] {
                            showCalendarDialog.toggle()
                            getAvailableCalendars()
                        } else {
                            showAlertNoGames = true
                        }
                    }
                ){
                    Image(systemName: "calendar.badge.plus")
                }
                
                .confirmationDialog("Choose a calendar to save the game(s)", isPresented: $showCalendarDialog, titleVisibility: .visible) {
                    
                    ForEach(calendarStrings, id: \.self) { calendarString in
                        Button(calendarString) {
                            for gamescore in gamescores {
                                let gameDate = getDatefromBSMString(gamescore: gamescore)

                                //if let localGameDate = gameDate {
                                    addGameToCalendar(gameDate: gameDate, gamescore: gamescore, calendarString: calendarString)
                                    showEventAlert = true
                                //}
                            }
                        }
                    }
                }
                
                .alert("Save to calendar", isPresented: $showEventAlert) {
                    Button("OK") { }
                } message: {
                    Text("All games have been saved.")
                }
                .padding(.horizontal, 10)
                
                .alert("Save to calendar", isPresented: $showAlertNoGames) {
                    Button("OK") { }
                } message: {
                    Text("There is no game data to save.")
                }
                .padding(.horizontal, 10)
            }
            
            //not sure if I want this
//            ToolbarItemGroup(placement: .principal) {
//                DatePicker("Select a specific date", selection: $filterDate, displayedComponents: .date)
//            }
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Picker(
                    selection: $selection,
                    //this actually does not show the label, just the selection
                    label: HStack {
                        Text("Show:")
                        //Text(selection)
                    },
                    content: {
                        ForEach(filterOptions, id: \.self) { option in
                            HStack {
                                Image(systemName: "list.bullet.circle")
                                Text(" " + option)
                            }
                            .tag(option)
                        }
                        
                })
                .pickerStyle(.menu)
                .padding(.vertical, scoresGridPadding)
            }
            //let's try to include refreshable here as well, the button is super ugly
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        print("trigger reload")
//                        loadGameData(url: gameURLSelected)
//                    }) {
//                        Label("Test", systemImage: "arrow.counterclockwise.circle")
//                            .padding(.horizontal, 15)
//                            //.font(.title2)
//                            //.frame(width: 10, height: 10, alignment: .trailing)
//                    }
//
//                }
        }
        .navigationTitle("Scores " + String(selectedSeason))
        #endif
        
        //---------------------------------------------------------//
        //-----------start Apple Watch-specific code---------------//
        //---------------------------------------------------------//
        
        #if os(watchOS)
        List {
            if loadingInProgress == true {
                LoadingView()
            }
            Picker(
                selection: $selection ,
                   
                label: HStack {
//                    Image(systemName: "list.bullet.circle")
//                        .foregroundColor(.skylarksRed)
                    Text(" Show:")
                },
            
                content: {
                    ForEach(filterOptions, id: \.self) { option in
                        HStack {
                            //Image(systemName: "list.bullet.circle")
                            Text(" " + option)
                        }
                        .tag(option)
                    }
                }
            )
                .pickerStyle(.automatic)
            
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
        }
        //.listStyle(.carousel)
        .navigationTitle("Scores " + String(selectedSeason))
        
        //APPLE WATCH SEPARATE FUNCS/////////////////////////////////////////////////////////////////////
        
        .onAppear(perform: {
            if gamescores.isEmpty {
                Task {
                    await loadLeagueGroups()
                }
            }
            getAvailableCalendars()
        })
        
        .onChange(of: selection, perform: { value in
            gamescores = []
            Task {
                await loadGamesAndProcess()
            }
        })
        
        .onChange(of: selectedSeason, perform: { value in
            gamescores = []
            //loadLeagueGroups()
        })
        
        #endif
    }
}

struct LoadingView: View {
    var body: some View {
        HStack {
            Text("Loading data...")
                .padding()
            ProgressView()
        }
    }
}


struct ScoresView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScoresView()
                //.preferredColorScheme(.dark)
        }
    }
}
