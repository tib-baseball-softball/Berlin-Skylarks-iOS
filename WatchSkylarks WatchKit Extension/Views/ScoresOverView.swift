//
//  ScoresOverView.swift
//  WatchSkylarks WatchKit Extension
//
//  Created by David Battefeld on 03.11.21.
//

import SwiftUI

struct ScoresOverView: View {
    var body: some View {
        VStack {
            Text("Final")
            Divider()
            HStack {
                VStack {
                    Image("Bird_whiteoutline")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    //Divider()
                    Text("8")
                        .font(.title)
                        .bold()
                }
                Spacer()
                VStack {
                    Image("Berlin_Flamingos_Logo_3D")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    //Divider()
                    Text("1")
                        .font(.title)
                        .bold()
                }
            }
            Divider()
            Text("W")
                .font(.title2)
                .bold()
                .foregroundColor(.green)
        }
        .padding(5)
    }
}

struct ScoresOverView_Previews: PreviewProvider {
    static var previews: some View {
        ScoresOverView()
    }
}
