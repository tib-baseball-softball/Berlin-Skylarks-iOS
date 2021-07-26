//
//  ModeData.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 25.01.21.
//

import Foundation

//change back the Model here!
// file is mostly obsolete right now


class apiCall: ObservableObject {
    @Published var gamescores = [GameScore]()
    func getScores() {
        guard let url = URL(string: "https://bsm.baseball-softball.de/clubs/485/matches.json?filter[seasons][]=2021&api_key=IN__8yHVCeE3gP83Dvyqww") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                DispatchQueue.main.async {
                    do {
                        print(data)
                        self.gamescores = try JSONDecoder().decode([GameScore].self, from: data)
                        print(self.gamescores)
                    }
                    catch {
                        print("nope try again")
                    }
                }
                
            }

            
            
        }
        .resume()
    }
}

//var gamescores: [GameScore] = apiCall().getScores()
//
var dummyGameScores: [GameScore] = loadDummyData("BSM_Games_2020_human_readable.json")
//
func loadDummyData<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
