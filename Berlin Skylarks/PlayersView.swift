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
        NavigationView {
            List {
                Section(header: PlayerDetailListHeader()) {
                    NavigationLink(
                        destination: PlayerDetailView()){
                            HStack {
                                Image(systemName: "person.fill")
                                    .font(.system(size: previewImageSize))
                                Spacer()
                                    .frame(width: SpacerWidth)
                                Text("Jaro Bruders")
                                    .font(.title2)
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
                        Text("Fritz Leidinger")
                            .font(.title2)
                        Spacer()
                        Text("22")
                            .font(.largeTitle)
                    }
                    HStack {
                        Image(systemName: "person.fill")
                            .font(.system(size: previewImageSize))
                        Spacer()
                            .frame(width: SpacerWidth)
                        Text("Jorge Carbonell Rodríguez")
                            .font(.title2)
                        Spacer()
                        Text("18")
                            .font(.largeTitle)
                    }
                }
            }
            .navigationBarTitle("Verbandsliga Baseball")
        }
    }
}

struct TeamPlayersView_Previews: PreviewProvider {
    static var previews: some View {
        TeamPlayersView()
            .preferredColorScheme(.dark)
            
    }
}
