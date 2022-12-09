//
//  PlayerDetailView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 25.12.20.
//

import SwiftUI

struct PlayerDetailView: View {
    var body: some View {
        List {
            //commented due to localization issues
//            Section(header: Text("Portrait")) {
//                HStack {
//                    Spacer()
//                    Image(systemName: "person.fill")
//                        .font(.system(size: 120))
//                    Spacer()
//                }
//            }
//            Section(header: Text("Main")) {
//                HStack {
//                    Text("Name")
//                    Spacer()
//                    Text("Jaro Bruders")
//                }
//                HStack {
//                    Text("Age")
//                    Spacer()
//                    Text("25")
//                }
//                HStack {
//                    Text("Club Member since")
//                    Spacer()
//                    Text("October 2015")
//                }
//            }
//            Section(header: Text("Game time")) {
//                HStack {
//                    Text("Team(s)")
//                    Spacer()
//                    Text("Team 1")
//                }
//                HStack {
//                    Text("Position")
//                    Spacer()
//                    Text("Pitcher, Corner Infielder") //that's not going to fit once a guy has a lot of positions
//                }
//                HStack {
//                    Text("Bats")
//                    Spacer()
//                    Text("Right")
//                }
//                HStack {
//                    Text("Throws")
//                    Spacer()
//                    Text("Right")
//                }
//            }
//            Section(header: Text("Licenses")) {
//                HStack {
//                    Text("Scorer")
//                    Spacer()
//                    Text("C")
//                }
//                HStack {
//                    Text("Umpire")
//                    Spacer()
//                    Text("A")
//                }
//            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Player Details")
    }
}

struct PlayerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerDetailView()
    }
}
