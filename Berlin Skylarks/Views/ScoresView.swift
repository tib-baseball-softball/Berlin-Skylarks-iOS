//
//  ScoresView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 26.12.20.
//

import SwiftUI

//struct ScoresListViewHeader: View {
//    var body: some View {
//        Text("League")
//    }
//}

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
                            .padding(ScoresItemPadding)
                            .padding(.horizontal)
                            .background(ItemBackgroundColor)
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
            
        }.onAppear(perform: loadData)
    }
}

extension ScoresView {
    func loadData() {
            
            //loads only previous gameday right now!
        
            guard let url = URL(string: "https://bsm.baseball-softball.de/clubs/485/matches.json?filter[seasons][]=2021&search=skylarks&filters[gamedays][]=previous&api_key=IN__8yHVCeE3gP83Dvyqww") else {
                return
            }
            
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
//old state

//struct ScoresView: View {
//    var body: some View {
//        NavigationView {
//            //apparently it should be possible to drop the id part but it throws an error
//            List(gamescores, id: \.id) { GameScore in
//                NavigationLink(destination: ScoresDetailView(gamescore: GameScore)) {
//                    ScoresOverView(gamescore: GameScore)
//                }
//            }
//            .listStyle(InsetGroupedListStyle())
//            .navigationTitle("Scores")
//
//          /*  .navigationBarItems(leading:
//                HStack {
//                    Image(systemName: "chevron.backward.circle.fill")
//                    Spacer(minLength: 85)
//                   // Text("Calendar Week") //this needs to be configured to select the week
//                }
//                                ,trailing:
//                    Image(systemName: "chevron.forward.circle.fill")
//            )*/
//
//        }
//    }
//}


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
