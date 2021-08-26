//
//  StandingsTableView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 10.08.21.
//

import SwiftUI

//this is a single table with ONE league. it can be accessed by tapping the corresponding league in StandingsView

struct StandingsTableView: View {
    var body: some View {
        List {
            Section(header: Text("Verbandsliga Baseball")) {
                HStack {
                    Text("#")
                        .bold()
                    Spacer()
                    Text("Team")
                        .bold()
                    Spacer()
                    HStack {
                        Text("W")
                            .bold()
                            .padding(.horizontal, 4)
                        Text("L")
                            .bold()
                            .padding(.horizontal, 4)
                        Text("GB")
                            .bold()
                            .padding(.horizontal, -1)
                    }.padding(.horizontal, -10)
                }
                .font(.title3)
                .foregroundColor(.white)
                .listRowBackground(Color.accentColor)
                
                HStack {
                    Text("1.")
                    Spacer()
                    Text("Skylarks")
                    Spacer()
                    HStack {
                        Text("14")
                            .padding(.horizontal, 5)
                        Text("2")
                            .padding(.horizontal, 5)
                        Text("0")
                            .padding(.horizontal, 1)
                    }
                    
                }
                HStack {
                    Text("2.")
                    Spacer()
                    Text("Sluggers")
                    Spacer()
                    HStack {
                        Text("4")
                            .padding(.horizontal, 5)
                        Text("4")
                            .padding(.horizontal, 5)
                        Text("2")
                            .padding(.horizontal, 1)
                    }
                    
                }
                HStack {
                    Text("3.")
                    Spacer()
                    Text("Dukes")
                    Spacer()
                    HStack {
                        Text("1")
                            .padding(.horizontal, 5)
                        Text("3")
                            .padding(.horizontal, 5)
                        Text("5")
                            .padding(.horizontal, 1)
                    }
                    
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct StandingsTableView_Previews: PreviewProvider {
    static var previews: some View {
        StandingsTableView()
    }
}

//old state with LazyVGrid

//let columns = [
//        GridItem(.flexible(minimum: 20, maximum: 30)),
//        GridItem(.flexible(minimum: 165, maximum: 400)),
//        GridItem(.flexible(minimum: 20, maximum: 30)),
//        GridItem(.flexible(minimum: 20, maximum: 30)),
//        GridItem(.flexible(minimum: 30, maximum: 30))
//    ]
//
//var body: some View {
//    LazyVGrid(columns: columns, spacing: 20) {
//        Group {
//            Text("#")
//                .bold()
//                .font(.title3)
//            Text("Team")
//                .bold()
//                .font(.title3)
//            Text("W")
//                .bold()
//                .font(.title3)
//            Text("L")
//                .bold()
//                .font(.title3)
//            Text("GB")
//                .bold()
//                .font(.title3)
//        }
//        //.foregroundColor(.white)
//        //.background(Color.accentColor)
//        Group {
//            Text("1.")
//            Text("Skylarks")
//            Text("7")
//            Text("2")
//            Text("0")
//        }
//        Group {
//            Text("2.")
//            Text("Sluggers")
//            Text("4")
//            Text("8")
//            Text("3")
//        }
//        Group {
//            Text("3.")
//            Text("SG Sluggers/Roadrunners/Sliders")
//            Text("4")
//            Text("8")
//            Text("3")
//        }
//    }
//    //.padding(.horizontal)
//}
