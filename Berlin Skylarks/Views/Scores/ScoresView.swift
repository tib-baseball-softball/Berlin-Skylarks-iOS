//
//  ScoresView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 26.12.20.
//

import SwiftUI

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
                        .pickerStyle(.menu)
                        .labelsHidden()
                    }
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
        ScoresView()
            
    }
}
