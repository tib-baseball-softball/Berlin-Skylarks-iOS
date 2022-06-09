//
//  SelectTeamSheet.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 07.06.22.
//

import SwiftUI

struct SelectTeamSheet: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    @State var teams = [BSMTeam]()
    @State var loadingTeams = false
    
    @AppStorage("selectedSeason") var selectedSeason = Calendar(identifier: .gregorian).dateComponents([.year], from: .now).year!
    @AppStorage("favoriteTeamID") var favoriteTeamID = 0
    
    func fetchTeams() async {
        loadingTeams = true
        do {
            teams = try await loadSkylarksTeams(season: selectedSeason)
            loadingTeams = false
        } catch {
            print("Request failed with error: \(error)")
        }
    }
    
    var body: some View {
        ZStack {
#if !os(watchOS)
            Color(colorScheme == .light ? .secondarySystemBackground : .systemBackground)
                .edgesIgnoringSafeArea(.all)
#endif
            Form {
                Section(
                    header: Text("Team selection required"),
                    footer: Text("You have changed the season. Please select a new favorite team for the home dashboard.")) {
                        if loadingTeams {
                            LoadingView()
                        } else {
                            Picker(selection: $favoriteTeamID,
                                   label:
                                    Text("Favorite Team")
                            ) {
                                ForEach(teams, id: \.self) { team in
                                    if !team.league_entries.isEmpty {
                                        Text("\(team.name) (\(team.league_entries[0].league.name))")
                                            .tag(team.id)
                                    }
                                }
                            }
                            .labelsHidden()
                            .pickerStyle(.inline)
                            HStack {
                                Spacer()
                                Button("Save favorite team") {
                                    dismiss()
                                }
                                .disabled(favoriteTeamID == 0)
                                .padding()
                                Spacer()
                            }
                        }
                    }
            }
        }
        .interactiveDismissDisabled()
        
        .onAppear(perform: {
            Task {
                await fetchTeams()
            }
        })
    }
}

struct SelectTeamSheet_Previews: PreviewProvider {
    static var previews: some View {
        SelectTeamSheet()
            .preferredColorScheme(.dark)
    }
}
