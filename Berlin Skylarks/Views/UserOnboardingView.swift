//
//  UserOnboardingView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 08.02.22.
//

import SwiftUI

struct UserOnboardingView: View {
    
    @AppStorage("favoriteTeam") var favoriteTeam: String = "Team 1"
    
    @State private var showingPicker = false
    
    @ObservedObject var userSettings = UserSettings()
    
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
                        Text("Favorite Team")
                            .bold()
                        Spacer()
                        Text(favoriteTeam)
                            .bold()
                            .foregroundColor(.skylarksSand)
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
                        Picker(selection: $favoriteTeam,
                               label:
                                    Text("Favorite Team")
                        ) {
                            ForEach(userSettings.skylarksTeams, id: \.self) { team in
                                Text(team)
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
