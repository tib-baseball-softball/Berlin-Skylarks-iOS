//
//  UserOnboardingView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 08.02.22.
//

import SwiftUI

struct UserOnboardingView: View {
    
    @State private var showingPicker = false
    @State var teams = [BSMTeam]()
    
    //@ObservedObject var userSettings = UserSettings()
    @AppStorage("favoriteTeamID") var favoriteTeamID = 0
    
    var body: some View {
        VStack {
            skylarksPrimaryLogo
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 200)
                .padding(.bottom)
            //Spacer()
            VStack(alignment: .leading) {
                Text("Welcome to the app!")
                    .font(.title)
                    .bold()
                    .padding(.vertical)
                Text("Please select your favorite team to optimize your experience. Your favorite team appears in the Home dashboard.")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                VStack {
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
                }
                .padding(.bottom)
            }
            .padding(.horizontal)
            .background(ScoresSubItemBackground)
            .cornerRadius(NewsItemCornerRadius)
        }
        .padding()
    }
}

struct UserOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        UserOnboardingView()
            //.preferredColorScheme(.dark)
    }
}
