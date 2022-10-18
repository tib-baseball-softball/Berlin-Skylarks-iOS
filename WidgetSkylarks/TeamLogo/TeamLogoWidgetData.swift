//
//  TeamLogoWidgetData.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 18.10.22.
//

import Foundation
import WidgetKit
import SwiftUI

struct TeamLogoEntryView: View {
    var entry: TeamLogoProvider.Entry
    
    var body: some View {
        TeamLogoWidgetView(entry: entry)
    }
}

struct TeamLogoProvider: TimelineProvider {
    typealias Entry = LogoEntry
    
    //we don't need to do anything here
    
    func placeholder(in context: Context) -> LogoEntry {
        let entry = LogoEntry(date: .now)
        return entry
    }
    
    func getSnapshot(in context: Context, completion: @escaping (LogoEntry) -> Void) {
        let entry = LogoEntry(date: .now)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<LogoEntry>) -> Void) {
        let entries = [LogoEntry(date: .now), LogoEntry(date: .now + 30)]
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
