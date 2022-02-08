//
//  ScoresView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 26.12.20.
//

import SwiftUI

struct ScoresView: View {
    
    @State private var gamescores = [GameScore]()
    
    @State private var showCalendarDialog = false
    @State private var showEventAlert = false
    @State private var showAlertNoGames = false
    @State private var loadingInProgress = false
    
    @State var selection: String = "Current Gameday"
    
    @State var gameURLSelected = urlCurrentGameday
    
    @State private var date = Date()

    let filterOptions: [String] = [
        "Previous Gameday", "Current Gameday", "Next Gameday", "Full Season", "Verbandsliga BB", "Verbandsliga SB", "Landesliga BB", "Bezirksliga BB", "Schülerliga", "Tossballliga",
    ]
    
    let columns = [
        GridItem(.adaptive(minimum: 300), spacing: scoresGridSpacing),
    ]
    
    func loadGamesAndProcess() {
        
        loadingInProgress = true
        
        loadBSMData(url: gameURLSelected, dataType: [GameScore].self) { loadedData in
            gamescores = loadedData
            loadingInProgress = false
        }
    }
    
    var body: some View {
        #if !os(watchOS)
        ScrollView {
            LazyVGrid(columns: columns, spacing: scoresGridSpacing) {
                if loadingInProgress == true {
                    LoadingView()
                }
                ForEach(self.gamescores, id: \.id) { GameScore in
                    NavigationLink(destination: ScoresDetailView(gamescore: GameScore)) {
                        ScoresOverView(gamescore: GameScore)
                    }
                    .foregroundColor(.primary)
                }
                if gamescores == [] && loadingInProgress == false {
                    Text("There are no Skylarks games scheduled for the chosen time frame.")
                }
            }
            .padding(scoresGridPadding)
        }
        .onAppear(perform: {
            loadGamesAndProcess()
            getAvailableCalendars()
        })
        
        .onChange(of: selection, perform: { value in
            for (string, url) in scoresURLs {
                if selection.contains(string) {
                    gameURLSelected = url
                }
            }
            loadGamesAndProcess()
        })
        
        // this is the toolbar with the picker in the top right corner where you can select which games to display.
    
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
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
                                gameDate = getDatefromBSMString(gamescore: gamescore)

                                if let localGameDate = gameDate {
                                    addGameToCalendar(gameDate: localGameDate, gamescore: gamescore, calendarString: calendarString)
                                    showEventAlert = true
                                }
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
            
            ToolbarItem(placement: .bottomBar) {
                
            }
        }
        //this does not work yet
//            .refreshable {
//                loadGameData(url: gameURLSelected)
//            }
        //this one leads to the weird constraint errors in console. Will ignore this for now.
        .navigationTitle("Scores")
        #endif
        
        //---------------------------------------------------------//
        //-----------start Apple Watch-specific code---------------//
        //---------------------------------------------------------//
        
        #if os(watchOS)
        List {
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
            if gamescores == [] {
                Text("There are no Skylarks games scheduled for the chosen time frame.")
                    .font(.caption2)
                    .padding()
            }
        }
        .listStyle(.carousel)
        .navigationTitle("Scores")
        
        .onAppear(perform: {
            loadGamesAndProcess()
        })
        
        .onChange(of: selection, perform: { value in
            for (string, url) in scoresURLs {
                if selection.contains(string) {
                    gameURLSelected = url
                }
            }
            loadGamesAndProcess()
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
        ScoresView()
            //.preferredColorScheme(.dark)
    }
}
