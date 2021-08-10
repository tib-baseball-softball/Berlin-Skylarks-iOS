//
//  StandingsTableView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 10.08.21.
//

import SwiftUI

struct StandingsTableView: View {
    
    let columns = [
            GridItem(.flexible(minimum: 20, maximum: 30)),
            GridItem(.flexible(minimum: 165, maximum: 400)),
            GridItem(.flexible(minimum: 20, maximum: 30)),
            GridItem(.flexible(minimum: 20, maximum: 30)),
            GridItem(.flexible(minimum: 30, maximum: 30))
        ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            Group {
                Text("#")
                    .bold()
                    .font(.title3)
                Text("Team")
                    .bold()
                    .font(.title3)
                Text("W")
                    .bold()
                    .font(.title3)
                Text("L")
                    .bold()
                    .font(.title3)
                Text("GB")
                    .bold()
                    .font(.title3)
            }
            Group {
                Text("1.")
                Text("Skylarks")
                Text("7")
                Text("2")
                Text("0")
            }
            Group {
                Text("2.")
                Text("Sluggers")
                Text("4")
                Text("8")
                Text("3")
            }
        }
        //.padding(.horizontal)
    }
}

struct StandingsTableView_Previews: PreviewProvider {
    static var previews: some View {
        StandingsTableView()
    }
}
