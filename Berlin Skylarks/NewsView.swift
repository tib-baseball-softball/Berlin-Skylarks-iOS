//
//  TabBarView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 23.12.20.
//

import SwiftUI


let ItemBackgroundColor = Color(UIColor.tertiarySystemBackground)
let PageBackgroundColor = Color(UIColor.secondarySystemBackground)
let NewsItemSpacing = 10 // not used yet

struct NewsView: View {
    var body: some View {

        VStack {
            HStack {
                Text("News")
                    .frame(alignment: .leading)
                    .font(.largeTitle)
                    .padding(15)
                Spacer()
            }
            ScrollView {
                
                
                VStack(
                    
                    spacing: 15
                    
                ) {
                    
                    VStack(
                        alignment: .leading,
                        spacing: 10
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
                    .cornerRadius(20.0)
                    .padding(15)
                    
                    VStack(
                        alignment: .leading,
                        spacing: 10
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
                    .cornerRadius(20.0)
                    .padding(15)
                    
                    VStack(
                        alignment: .leading,
                        spacing: 10
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
                    .cornerRadius(20.0)
                    .padding(10)
                }
            }
            
        }
    }
  //  .background(PageBackgroundColor) //throws error
}


//DEBUG

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
            .preferredColorScheme(.dark)
            
            }
}
