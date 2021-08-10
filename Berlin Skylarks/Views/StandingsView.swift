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
                        Text("#")
                            .bold()
                        Spacer()
                        Text("Team")
                            .bold()
                        Spacer()
                        HStack {
                            Text("W")
                                .bold()
                                .padding(.horizontal, 4)
                            Text("L")
                                .bold()
                                .padding(.horizontal, 4)
                            Text("GB")
                                .bold()
                                .padding(.horizontal, -1)
                        }.padding(.horizontal, -10)
                    }
                    .font(.title3)
                    .foregroundColor(.white)
                    .listRowBackground(Color.accentColor)
                    
                    HStack {
                        Text("1.")
                        Spacer()
                        Text("Skylarks")
                        Spacer()
                        HStack {
                            Text("14")
                                .padding(.horizontal, 5)
                            Text("2")
                                .padding(.horizontal, 5)
                            Text("0")
                                .padding(.horizontal, 1)
                        }
                        
                    }
                }
                Section(header: Text("Test section")) {
                    StandingsTableView()
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
