//
//  TestView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.09.21.
//

import SwiftUI
import MapKit

struct TestView: View {

    //var gamescore: GameScore
    
    @Environment(\.colorScheme) var colorScheme

    #if !os(watchOS)
//    init() {
//        UITableView.appearance().backgroundColor = .clear
//    }
    #endif
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(colorScheme == .light ? .secondarySystemBackground : .systemBackground)
                    .edgesIgnoringSafeArea(.all)
                List {
                    Group {
                        Section(header: Text("Test Header"),
                                footer: Text("Footer")) {
                            HStack {
                                Text("Hier steht was")
                                Spacer()
                                Text("was anderes")
                            }
                            
                            .listItemTint(.skylarksRed)
                            HStack {
                                Text("Hier steht was")
                                Spacer()
                                Text("was anderes")
                            }
                        }
                        HStack {
                            Text("Hier steht was")
                            Spacer()
                            Text("was anderes")
                        }
                        HStack {
                            Text("Hier steht was")
                            Spacer()
                            Text("was anderes")
                        }
                    }
                    //.listRowBackground(ScoresSubItemBackground)
                }
                .listStyle(.insetGrouped)
            .frame(maxWidth: 600)
            }
            .navigationTitle("Test View")
            //.navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
            //.preferredColorScheme(.dark)
            //.previewInterfaceOrientation(.landscapeLeft)
    }
}
