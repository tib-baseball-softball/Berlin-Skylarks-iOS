//
//  ModeData.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 25.01.21.
//

import Foundation

//at the moment this serves just to get some dummy data for prototyping

var dummyGameScores: [GameScore] = loadDummyData("BSM_Games_2020_human_readable.json")

var dummyLeagueTable: LeagueTable = loadDummyData("VLBB_2021_Standings.json")


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


//func loadTableDataDebug(url: URL) {
//
//        let request = URLRequest(url: url)
//        URLSession.shared.dataTask(with: request) { data, response, error in
//
//            if let data = data {
//                if let response_obj = try? JSONDecoder().decode(LeagueTable.self, from: data) {
//
//                    DispatchQueue.main.async {
//                        dummyLeagueTable = response_obj
//                    }
//                }
//            }
//        }
//}
