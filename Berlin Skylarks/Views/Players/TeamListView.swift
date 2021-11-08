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
    var body: some View {
        NavigationView {
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
                
            }
            .navigationBarTitle("Teams")
            .listStyle(.insetGrouped)
            
        }
        .navigationViewStyle(.stack)
    }
}

struct TeamListView_Previews: PreviewProvider {
    static var previews: some View {
        TeamListView()
    }
}
