//
//  TeamListView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 25.12.20.
//

import SwiftUI

struct TeamDetailListHeader: View {
    var body: some View {
        HStack {
            Image(systemName: "number")
            Spacer()
            Text("Team")
            Spacer()
            Text("Sport")
        }
    }
}

struct TeamListView: View {
    
    @State var leagueGroups = [LeagueGroup]()
    
    let leagueGroupURL = URL(string:"https://bsm.baseball-softball.de/league_groups.json?filters[seasons][]=2021&api_key=" + apiKey)!
    
    var body: some View {
        List {
            Section(header: TeamDetailListHeader()) {
                NavigationLink(
                    destination: TeamPlayersView()){
                        HStack {
                            Text("1")
                            Spacer()
                            Text("Verbandsliga")
                            Spacer()
                            Text("Baseball")
                        }
                }
                HStack {
                    Text("2")
                    Spacer()
                    Text("Landesliga")
                    Spacer()
                    Text("Baseball")
                }
                HStack {
                    Text("3")
                    Spacer()
                    Text("Bezirksliga")
                    Spacer()
                    Text("Baseball")
                }
            }
            Text(leagueGroups.debugDescription)
            
        }
        .navigationBarTitle("Teams")
        .listStyle(.insetGrouped)
    
        .onAppear(perform: {
            if leagueGroups == [] {
                loadBSMData(url: leagueGroupURL, dataType: [LeagueGroup].self) { loadedData in
                    leagueGroups = loadedData
                }
            }
        })
    }
}

struct TeamListView_Previews: PreviewProvider {
    static var previews: some View {
        TeamListView()
    }
}
