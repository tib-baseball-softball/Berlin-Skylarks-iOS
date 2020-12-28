//
//  TabBarView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 23.12.20.
//

import SwiftUI


let ItemBackgroundColor = Color(UIColor.tertiarySystemFill)
//let PageBackgroundColor = Color(UIColor.secondarySystemBackground) //using standard backgrounds for now
let NewsItemSpacing: CGFloat = 10
let NewsItemCornerRadius: CGFloat = 20.0
let NewsItemPadding: CGFloat = 15

//right now all news items lead to the same page

struct NewsView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(
                    destination: NewsDetailView()) {
                        VStack(
                            alignment: .leading,
                            spacing: NewsItemSpacing
                        ) {
                            Image("dummy_field")
                                .resizable()
                                .scaledToFit()
                            Text("Spielbericht")
                                .font(.title3)
                                .padding(10)
                            Text("Skylarks gewinnen durch Homerun im 9. Inning nach heroischer Performance")
                                .font(.headline)
                                .lineLimit(nil)
                                .padding(10)
                        }
                        .background(ItemBackgroundColor)
                        .cornerRadius(NewsItemCornerRadius)
                        .padding(NewsItemPadding)
                        .foregroundColor(.primary)
                }
                NavigationLink(
                    destination: NewsDetailView()) {
                        VStack(
                            alignment: .leading,
                            spacing: NewsItemSpacing
                        ) {
                            Image("dummy_kids")
                                .resizable()
                                .scaledToFit()
                            Text("Eventbericht")
                                .font(.title3)
                                .padding(10)
                            Text("Kinder hatten ganz viel Spaß")
                                .font(.headline)
                                .lineLimit(nil)
                                .padding(10)
                        }
                        .background(ItemBackgroundColor)
                        .cornerRadius(NewsItemCornerRadius)
                        .padding(NewsItemPadding)
                        .foregroundColor(.primary)
                }
                NavigationLink(
                    destination: NewsDetailView()) {
                        VStack(
                            alignment: .leading,
                            spacing: NewsItemSpacing
                        ) {
                            Image("Rondell")
                                .resizable()
                                .scaledToFit()
                            Text("Designprozess")
                                .font(.title3)
                                .padding(10)
                            Text("Breaking News: Skylarks immer noch bestaussehendster Verein Berlins")
                                .font(.headline)
                                .lineLimit(nil)
                                .padding(10)
                        }
                        .background(ItemBackgroundColor)
                        .cornerRadius(NewsItemCornerRadius)
                        .padding(NewsItemPadding)
                        .foregroundColor(.primary)
                }
            } .navigationBarTitle("News")
            .listStyle(InsetListStyle())
        }
    }
}


//DEBUG

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
            }
}
