//
//  UserOnboardingView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 08.02.22.
//

import SwiftUI

struct UserOnboardingView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var showingPicker = false
    @State var teams = [BSMTeam]()
    
    //this is always the current year here, so it should be set immediately
    @AppStorage("selectedSeason") var selectedSeason = Calendar(identifier: .gregorian).dateComponents([.year], from: .now).year!
    
    @AppStorage("favoriteTeamID") var favoriteTeamID = 0
    
    func fetchTeams() async {
        do {
            teams = try await loadSkylarksTeams(season: selectedSeason)
        } catch {
            print("Request failed with error: \(error)")
        }
    }
    
    var body: some View {
        VStack {
            skylarksPrimaryLogo
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 200)
                .padding(.bottom)
            //Spacer()
            VStack(alignment: .leading, spacing: 15) {
                Text("Welcome to the app!")
                    .font(.title)
                    .bold()
                    .padding(.top)
                Text("Please select your favorite team to optimize your experience. Your favorite team appears in the Home dashboard.")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                VStack {
                    if !teams.isEmpty {
                        HStack {
                            Image(systemName: "star.square.fill")
                                .font(.title)
                            Spacer()
                            Text("Select Favorite Team")
                                .bold()
                            Spacer()
                        }
                        .font(.title3)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.skylarksRed)
                        .cornerRadius(10)
                        
                        .onTapGesture {
                            withAnimation {
                                showingPicker.toggle()
                            }
                        }
                        if showingPicker == true {
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
                            .transition(.scale)
                            .pickerStyle(.wheel)
                        }
                    } else {
                        HStack {
                            Text("Loading teams for current season...")
                            Spacer()
                            ProgressView()
                        }
                        .padding()
                        .font(.title3)
                        .background(ItemBackgroundColor)
                        .cornerRadius(10)
                    }
                }
                .padding(.bottom)
                
            }
            .padding(.horizontal)
            .background(ScoresSubItemBackground)
            .cornerRadius(NewsItemCornerRadius)
            HStack {
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Text("Accept selection")
                }
                .padding()
                .font(.title3)
                //tappable only after a favorite team is selected
                .disabled(favoriteTeamID == 0)
                Spacer()
            }
            .background(ScoresSubItemBackground)
            .cornerRadius(NewsItemCornerRadius)
            
        }
        .padding()
        //cannot be closed by gesture
        .interactiveDismissDisabled()
        
        .onAppear(perform: {
            Task {
                await fetchTeams()
            }
        })
    }
}

struct UserOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        UserOnboardingView()
            //.preferredColorScheme(.dark)
    }
}
