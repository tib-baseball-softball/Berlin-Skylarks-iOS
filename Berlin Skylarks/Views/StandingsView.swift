//
//  StandingsView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.12.20.
//

var myString = "Hallo Lena"
var Abstand = 40

import SwiftUI

struct StandingsView: View {
    var body: some View {
        VStack {
            Text(String(Abstand))
            Text("Test")
        }
    }
}

struct StandingsView_Previews: PreviewProvider {
    static var previews: some View {
        StandingsView()
    }
}
