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
    
    @State var selection: String = "Current Gameday"
    
    @State var gameURLSelected = urlCurrentGameday
    
    @State private var date = Date()

    let filterOptions: [String] = [
        "Previous Gameday", "Current Gameday", "Next Gameday", "Full Season", "Verbandsliga BB", "Verbandsliga SB", "Landesliga BB", "Bezirksliga BB", "Schülerliga", "Tossballliga",
    ]
    
    let columns = [
        GridItem(.adaptive(minimum: 300), spacing: scoresGridSpacing),
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: scoresGridSpacing) {
                    ForEach(self.gamescores, id: \.id) { GameScore in
                        NavigationLink(destination: ScoresDetailView(gamescore: GameScore)) {
                            ScoresOverView(gamescore: GameScore)
                        }
                        .foregroundColor(.primary)
                    }
                    if !gamescores.indices.contains(0) {
                        Text("There are no Skylarks games scheduled for the chosen time frame.")
                    }
                }
                .padding(scoresGridPadding)
            }
            
            
            .onAppear(perform: { loadGameData(url: gameURLSelected) })
            
            //I need to get what "value" means here --> type is string, like selection. Code works anyway.
            .onChange(of: selection, perform: { value in
                for (string, url) in scoresURLs {
                    if selection.contains(string) {
                        gameURLSelected = url
                    }
                }
                loadGameData(url: gameURLSelected)
            })
            
            // this is the toolbar with the picker in the top right corner where you can select which games to display.
            
            .toolbar {
//                ToolbarItem(placement: .principal) {
//                    DatePicker(
//                        "Game Date",
//                        selection: $date,
//                        displayedComponents: [.date]
//                    )
//                    .padding(40)
//                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(
                        action: {
                            showCalendarDialog.toggle()
                        }
                    ){
                        Image(systemName: "calendar.badge.plus")
                    }
                    .confirmationDialog("Save game to calendar", isPresented: $showCalendarDialog) {
                        Button("Save to calendar") {
                            print("saved to calendar")

                            //add actual action here
                        }
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
                    .pickerStyle(.automatic)
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
        }
        .navigationViewStyle(.stack)
    }
}

extension ScoresView {
    func loadGameData(url: URL) {
        
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let data = data {
                    if let response_obj = try? JSONDecoder().decode([GameScore].self, from: data) {
                        
                        DispatchQueue.main.async {
                            self.gamescores = response_obj
                        }
                    }
                }
            }.resume()
    }
}


struct ScoresView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ScoresView().preferredColorScheme($0)
        }
    }
}
