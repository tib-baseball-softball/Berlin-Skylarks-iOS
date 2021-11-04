//
//  ScoresView.swift
//  WatchSkylarks WatchKit Extension
//
//  Created by David Battefeld on 03.11.21.
//

import SwiftUI

struct ScoresView: View {
    
    @State var selection: String = "Option 1"
    
    var body: some View {
        List {
            Picker(
                selection: $selection ,
                   
                label: HStack {
                    Image(systemName: "star.fill")
                    Text("Test")
                },
            
                content: {
                    Text("Option 1")
                    Text("Option 2")
                    Text("Option 3")
                }
            )
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
