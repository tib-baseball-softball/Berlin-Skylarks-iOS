//
//  PlayersView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 25.12.20.
//

import SwiftUI

let previewImageSize: CGFloat = 50.0
let SpacerWidth: CGFloat = 15

struct PlayerDetailListHeader: View {
    var body: some View {
        HStack {
            Image(systemName: "photo")
            Spacer()
            Text("Name")
            Spacer()
            Text("Jersey Number")
        }
    }
}

struct TeamPlayersView: View {
    var body: some View {
        List {
            Section(header: PlayerDetailListHeader()) {
                NavigationLink(
                    destination: PlayerDetailView()){
                        HStack {
                            Image(systemName: "person.fill")
                                .font(.system(size: previewImageSize))
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                            Spacer()
                                .frame(width: SpacerWidth)
                            Text("Jaro Bruders")
                            Spacer()
                            Text("21")
                                .font(.largeTitle)
                        }
                }
                HStack {
                    Image(systemName: "person.fill")
                        .font(.system(size: previewImageSize))
                    Spacer()
                        .frame(width: SpacerWidth)
                    Text("Sample Player 1")
                    Spacer()
                    Text("22")
                        .font(.largeTitle)
                }
                HStack {
                    Image(systemName: "person.fill")
                        .font(.system(size: previewImageSize))
                    Spacer()
                        .frame(width: SpacerWidth)
                    Text("Sample Player 2")
                    Spacer()
                    Text("18")
                        .font(.largeTitle)
                }
                HStack {
                    Image(systemName: "person.fill")
                        .font(.system(size: previewImageSize))
                    Spacer()
                        .frame(width: SpacerWidth)
                    Text("Sample Player 2")
                    Spacer()
                    Text("42")
                        .font(.largeTitle)
                }
                HStack {
                    Image(systemName: "person.fill")
                        .font(.system(size: previewImageSize))
                    Spacer()
                        .frame(width: SpacerWidth)
                    Text("Sample Player 2")
                    Spacer()
                    Text("1")
                        .font(.largeTitle)
                }
                HStack {
                    Image(systemName: "person.fill")
                        .font(.system(size: previewImageSize))
                    Spacer()
                        .frame(width: SpacerWidth)
                    Text("Sample Player 2")
                    Spacer()
                    Text("101")
                        .font(.largeTitle)
                }
                HStack {
                    Image(systemName: "person.fill")
                        .font(.system(size: previewImageSize))
                    Spacer()
                        .frame(width: SpacerWidth)
                    Text("Sample Player 2")
                    Spacer()
                    Text("5")
                        .font(.largeTitle)
                }
            }
        }
        .navigationBarTitle("Verbandsliga Baseball")
        .listStyle(InsetGroupedListStyle())
    }
}

struct TeamPlayersView_Previews: PreviewProvider {
    static var previews: some View {
        TeamPlayersView()
    }
}
