//
//  ScoresOverView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 27.12.20.
//

import SwiftUI

let ScoresItemSpacing: CGFloat = 20.0
let ScoresNumberPadding: CGFloat = 20.0
let ScoresSubItemBackground = Color(UIColor.tertiarySystemFill)
let ScoresItemPadding: CGFloat = 10.0

struct ScoresOverView: View {
    var body: some View {
        VStack(spacing: ScoresItemSpacing) {
            HStack {
                Text("ID: 12847")
                    .italic()
                Spacer()
                Text("Saturday, May 8th, 2021")
                    .italic()
            }
            .font(.subheadline)
            HStack {
                VStack {
                    Text("Guest")
                        .bold()
                    Image("Berlin_Flamingos_Logo_3D")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    Text("Berlin Flamingos 2")
                        .lineLimit(nil)
                }
                Spacer()
                Text("2")
                    .font(.largeTitle)
                    .bold()
                    .padding(ScoresNumberPadding)
            }
            .padding(ScoresItemPadding)
            .background(ScoresSubItemBackground)
            .cornerRadius(NewsItemCornerRadius)
            HStack {
                VStack {
                    Text("Home")
                        .bold()
                    Image("Bird_whiteoutline")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    Text("Berlin Skylarks 1")
                        .lineLimit(nil)
                }
                Spacer()
                Text("5")
                    .font(.largeTitle)
                    .bold()
                    .padding(ScoresNumberPadding)
                    .foregroundColor(Color("AccentColor"))
            }
            .padding(ScoresItemPadding)
            .background(ScoresSubItemBackground)
            .cornerRadius(NewsItemCornerRadius)
            HStack {
                Text("Gail S. Halvorsen Park")
                    .italic()
                Spacer()
                Text("Berlin")
                    .italic()
            }.font(.subheadline)
        }
        .padding(ScoresItemPadding)
//        .background(ItemBackgroundColor) //not needed because of new list style
        .cornerRadius(NewsItemCornerRadius)
    }
}

struct ScoresOverView_Previews: PreviewProvider {
    static var previews: some View {
        ScoresOverView()
    }
}
