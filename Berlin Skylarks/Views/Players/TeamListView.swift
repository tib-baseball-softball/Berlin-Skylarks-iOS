//
//  TeamListView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 25.12.20.
//

import SwiftUI

struct TeamDetailListHeader: View {
    var body: some View {
        Text("Team data")
    }
}

struct TeamListView: View {
    
    @State var teams = [BSMTeam]()
    
    @State private var loadingInProgress = false
    
    @AppStorage("selectedSeason") var selectedSeason = Calendar(identifier: .gregorian).dateComponents([.year], from: .now).year!
    
    let teamURL = URL(string:"https://bsm.baseball-softball.de/clubs/485/teams.json?filters[seasons][]=" + currentSeason + "&sort[league_sort]=asc&api_key=" + apiKey)!
    
    var body: some View {
        List {
            Section(header: TeamDetailListHeader()) {
                HStack {
                    Image(systemName: "person.3.fill")
                        .padding(.trailing)
                    Text("Team")
                    Spacer()
                    Text("League")
                        .frame(maxWidth: 110, alignment: .leading)
                        .padding(.trailing)
                }
                //.padding(.horizontal)
                .font(.headline)
                .listRowBackground(ColorStandingsTableHeadline)
                
                if loadingInProgress == true {
                    LoadingView()
                }
                
                ForEach(teams, id: \.self) { team in
                    NavigationLink(
                        destination: TeamDetailView(team: team)){
                            HStack {
                                Image(systemName: "person.3")
                                    .foregroundColor(.skylarksRed)
                                    .padding(.trailing)
                                Text(team.name)
                                Spacer()
                                if !team.league_entries.isEmpty {
                                    Text(team.league_entries[0].league.name)
                                        .frame(maxWidth: 110, alignment: .leading)
                                        .allowsTightening(true)
                                }
                            }
                    }
                }
                //.padding(.horizontal)
                //Text(teams.debugDescription)
            }
            
        }
        .navigationBarTitle("Teams")
        .listStyle( {
          #if os(watchOS)
            .automatic
          #else
            .insetGrouped
          #endif
        } () )
        .refreshable {
            teams = []
            loadBSMData(url: teamURL, dataType: [BSMTeam].self) { loadedData in
                teams = loadedData
            }
        }
    
        .onAppear(perform: {
            if teams == [] {
                loadingInProgress = true
                loadBSMData(url: teamURL, dataType: [BSMTeam].self) { loadedData in
                    teams = loadedData
                    loadingInProgress = false
                }
            }
        })
    }
}

struct TeamListView_Previews: PreviewProvider {
    static var previews: some View {
        TeamListView()
            //.preferredColorScheme(.dark)
    }
}
