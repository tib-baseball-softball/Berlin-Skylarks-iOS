//
//  ScoresView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 26.12.20.
//

import SwiftUI

//BSM API URLS to get the games //////
//those are hardcoded to the year 2021 - so I would need to push an update at least once a year, but there might also be a solution that works continually

//force unwrapping should not be an issue here - these are never nil

let urlPreviousGameday = URL(string: "https://bsm.baseball-softball.de/clubs/485/matches.json?filter[seasons][]=2021&search=skylarks&filters[gamedays][]=previous&api_key=IN__8yHVCeE3gP83Dvyqww")!
let urlCurrentGameday = URL(string: "https://bsm.baseball-softball.de/clubs/485/matches.json?filter[seasons][]=2021&search=skylarks&filters[gamedays][]=current&api_key=IN__8yHVCeE3gP83Dvyqww")!
let urlNextGameday = URL(string: "https://bsm.baseball-softball.de/clubs/485/matches.json?filter[seasons][]=2021&search=skylarks&filters[gamedays][]=next&api_key=IN__8yHVCeE3gP83Dvyqww")!
let urlFullSeason = URL(string: "https://bsm.baseball-softball.de/clubs/485/matches.json?filter[seasons][]=2021&search=skylarks&filters[gamedays][]=any&api_key=IN__8yHVCeE3gP83Dvyqww")!

let scoresURLs = [
    "Previous Gameday": urlPreviousGameday,
    "Current Gameday": urlCurrentGameday,
    "Next Gameday": urlNextGameday,
    "Full Season": urlFullSeason,
]

let scoresGridSpacing: CGFloat = 25
let scoresGridPadding: CGFloat = 20

var isLoadingScores = false

struct ScoresView: View {
    
    @State private var gamescores = [GameScore]()
    
    @State var selection: String = "Current Gameday"
    
    @State var gameURLSelected = urlCurrentGameday

    let filterOptions: [String] = [
        "Previous Gameday", "Current Gameday", "Next Gameday", "Full Season",
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
            //.listStyle(InsetGroupedListStyle())
            .navigationTitle("Scores")
            
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
                ToolbarItemGroup {
                    HStack {
                        Button(action: {
                            print("trigger reload")
                            loadGameData(url: gameURLSelected)
                        }) {
                            Label("Test", systemImage: "arrow.counterclockwise.circle")
                                .padding(.horizontal, 15)
                                //.font(.title2)
                                //.frame(width: 10, height: 10, alignment: .trailing)
                        }
                        Picker(
                            selection: $selection,
                            label: HStack {
                                Text("Show:")
                                //Text(selection)
                            }
                            .font(.headline)
                           // .padding(ScoresItemPadding)
                            .padding(.horizontal)
                            //.background(ItemBackgroundColor)
                            .cornerRadius(NewsItemCornerRadius)
                            ,
                            content: {
                                ForEach(filterOptions, id: \.self) { option in
                                    Label(option, systemImage: "list.bullet.circle")
                                        //.labelStyle(.iconOnly)
//                                    HStack {
//                                        Image(systemName: "list.bullet.circle")
//                                            .frame(width: 10)
//                                        Text(option)
//                                    }
                                    .tag(option)
                                }
                                
                        })
                        .pickerStyle(MenuPickerStyle())
                        .labelsHidden()
                    }
                }
            }
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
            //isLoadingScores = false
            }.resume()
    }
}


struct ScoresView_Previews: PreviewProvider {
    static var previews: some View {
        ScoresView()
            
    }
}
