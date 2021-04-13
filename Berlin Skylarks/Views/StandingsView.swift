//
//  StandingsView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.12.20.
//

import SwiftUI

struct StandingsView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Verbandsliga Baseball")) {
                    HStack {
                        Text("1")
                        Spacer()
                        Text("Skylarks")
                        Spacer()
                        Text("7:2")
                    }
                    HStack {
                        Text("2")
                        Spacer()
                        Text("Sample Team")
                        Spacer()
                        Text("4:5")
                    }
                    HStack {
                        Text("3")
                        Spacer()
                        Text("Sample Team")
                        Spacer()
                        Text("3:6")
                    }
                    HStack {
                        Text("4")
                        Spacer()
                        Text("Sample Team")
                        Spacer()
                        Text("0:9")
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Standings")
        }
        
    }
}

struct StandingsView_Previews: PreviewProvider {
    static var previews: some View {
        StandingsView()
    }
}
