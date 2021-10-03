//
//  TestView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.09.21.
//

import SwiftUI

struct TestView: View {

    let columns = [
        GridItem(.adaptive(minimum: 300), spacing: scoresGridSpacing),
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
//                HStack {
//                    Text("Scores")
//                        .bold()
//                        .font(.largeTitle)
//                    Spacer()
//                    Image(systemName: "arrow.counterclockwise.circle")
//                        .font(.largeTitle)
//                    Image(systemName: "list.bullet.circle")
//                        .font(.largeTitle)
//                }
//                .padding(.horizontal, 25)
                LazyVGrid(columns: columns, spacing: scoresGridSpacing) {
                    ForEach(dummyGameScores, id: \.self) { GameScore in
                        ScoresOverView(gamescore: GameScore)
                    }
                }
                .padding(scoresGridPadding)
            }
            .navigationTitle("Scores")
            //.frame(maxHeight: 400)
            .toolbar {
                
            }
        }
        .navigationViewStyle(.stack)
    }
    
    //this is how you can declare functions in a view!
    
    private func printSomething() {
        print(self)
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
            .previewDevice("iPad Air (4th generation)")
    }
}
