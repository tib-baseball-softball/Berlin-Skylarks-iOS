//
//  ScoresView.swift
//  WatchSkylarks WatchKit Extension
//
//  Created by David Battefeld on 03.11.21.
//

import SwiftUI

struct ScoresView: View {
    var body: some View {
        List {
            NavigationLink(
                destination: ScoresDetailView()) {
                    ScoresOverView()
                }
            NavigationLink(
                destination: ScoresDetailView()) {
                    ScoresOverView()
                }
            NavigationLink(
                destination: ScoresDetailView()) {
                    ScoresOverView()
                }
            NavigationLink(
                destination: ScoresDetailView()) {
                    ScoresOverView()
                }
        }
        .listStyle(.carousel)
        .navigationTitle("Scores")
    }
}

struct ScoresView_Previews: PreviewProvider {
    static var previews: some View {
        ScoresView()
    }
}
