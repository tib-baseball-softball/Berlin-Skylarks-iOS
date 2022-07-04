//
//  GamedayWidgetData.swift
//  WidgetSkylarksExtension
//
//  Created by David Battefeld on 04.07.22.
//

import WidgetKit
import SwiftUI

struct GamedayTimeline: TimelineProvider {
    //typealias Entry = GamedayEntry
    
    func placeholder(in context: Context) -> GamedayEntry {
        GamedayEntry(date: Date(), gamescores: dummyGameScores)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (GamedayEntry) -> Void) {
        let entry = GamedayEntry(date: Date(), gamescores: dummyGameScores)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<GamedayEntry>) -> Void) {
        Task {
            //always the current season
            let season = Calendar(identifier: .gregorian).dateComponents([.year], from: .now).year!
            
            //always using current as gameday URL parameter
            let url = URL(string: "https://bsm.baseball-softball.de/matches.json?filters[seasons][]=" + "\(season)" + "&search=skylarks&filters[gamedays][]=current&api_key=" + apiKey)!
            
            var gamescores = [GameScore]()
            do {
                gamescores = try await fetchBSMData(url: url, dataType: [GameScore].self)
            } catch {
                print("Request failed with error: \(error)")
            }
            
            var entries: [GamedayEntry] = []
            
            let currentDate = Date()
            for hourOffset in 0 ..< 4 {
                let entryDate = Calendar.current.date(byAdding: .minute, value: hourOffset * 20, to: currentDate)!
                let entry = GamedayEntry(date: entryDate, gamescores: gamescores)
                entries.append(entry)
            }
            
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
    }
}

struct GamedayWidgetEntryView: View {
    var entry: GamedayTimeline.Entry
    
    var body: some View {
        GamedayWidgetView(entry: entry)
    }
}
