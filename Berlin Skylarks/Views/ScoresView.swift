//
//  ScoresView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 26.12.20.
//

import SwiftUI

//this is some old trash of which I have no knowledge of
//struct ScoresListViewHeader: View {
//    var body: some View {
//        Text("League")
//    }
//}

//BSM API URLS to get the games //////
//those are hardcoded to the year 2021 - so I would need to push an update at least once a year, but there might also be a solution that works continually

//force unwrapping should not be an issue here - these are never nil

let urlPrevious: URL = URL(string: "https://bsm.baseball-softball.de/clubs/485/matches.json?filter[seasons][]=2021&search=skylarks&filters[gamedays][]=previous&api_key=IN__8yHVCeE3gP83Dvyqww")!
let urlCurrent = URL(string: "https://bsm.baseball-softball.de/clubs/485/matches.json?filter[seasons][]=2021&search=skylarks&filters[gamedays][]=current&api_key=IN__8yHVCeE3gP83Dvyqww")!
let urlNext = URL(string: "https://bsm.baseball-softball.de/clubs/485/matches.json?filter[seasons][]=2021&search=skylarks&filters[gamedays][]=next&api_key=IN__8yHVCeE3gP83Dvyqww")!
let urlAll = URL(string: "https://bsm.baseball-softball.de/clubs/485/matches.json?filter[seasons][]=2021&search=skylarks&filters[gamedays][]=any&api_key=IN__8yHVCeE3gP83Dvyqww")!

var urlSelected: URL? = urlCurrent

struct ScoresView: View {
    
    @State private var gamescores = [GameScore]()
    
    @State var selection: String = "Current Gameday"
    let filterOptions: [String] = [
        "Previous Gameday", "Current Gameday", "Next Gameday", "Full Season",
    ]
    
    var body: some View {
        NavigationView {
    
            List(self.gamescores, id: \.id) { GameScore in
                NavigationLink(destination: ScoresDetailView(gamescore: GameScore)) {
                    ScoresOverView(gamescore: GameScore)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Scores")
            
            // this is the toolbar with the picker in the top right corner where you can select which games to display. TODO: bind to View so that the appropriate games are dynamically loaded on selection.
            
            .toolbar {
                ToolbarItem {
                    HStack {
                        Picker(
                            selection: $selection,
                            label: HStack {
                                Text("Show:")
                                Text(selection)
                            }
                            .font(.headline)
                           // .padding(ScoresItemPadding)
                            .padding(.horizontal)
                            //.background(ItemBackgroundColor)
                            .cornerRadius(NewsItemCornerRadius)
                            ,
                            content: {
                                ForEach(filterOptions, id: \.self) { option in
                                    HStack {
                                        Text(option)
                                        Image(systemName: "list.bullet")
                                    }
                                    .tag(option)
                                }
                        })
                        .pickerStyle(MenuPickerStyle())
                    }
                }
            }
            
        }.onAppear(perform: { loadData(url: urlCurrent) })
    }
}

extension ScoresView {
    func loadData(url: URL) {
            
            //this was the previous version
        
//            guard let url = URL(string: "https://bsm.baseball-softball.de/clubs/485/matches.json?filter[seasons][]=2021&search=skylarks&filters[gamedays][]=previous&api_key=IN__8yHVCeE3gP83Dvyqww") else {
//                return
//            }
            
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
        ScoresView()
        /*
        ForEach(["iPhone 12", "iPhone 8", "iPad Pro (9.7-inch)"], id: \.self) { deviceName in
            ScoresView()
                        .previewDevice(PreviewDevice(rawValue: deviceName))
                }
        */
    }
}
