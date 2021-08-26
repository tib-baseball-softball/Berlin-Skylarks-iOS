//
//  StandingsView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.12.20.
//

import SwiftUI

let StandingsRowPadding: CGFloat = 10

let leagues = ["Verbandsliga Baseball", "Landesliga Baseball", "Verbandsliga Softball" ]

struct StandingsView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Please select your league")) {
                    ForEach(leagues, id: \.self) { league in
                        NavigationLink(
                            destination: StandingsTableView(),
                            label: {
                                HStack {
                                    Image(systemName: "tablecells")
                                        .padding(.trailing, 3)
                                        .foregroundColor(Color.accentColor)
                                    Text(league)
                                }
                            })
                    }
                    
                    .padding(StandingsRowPadding)
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
