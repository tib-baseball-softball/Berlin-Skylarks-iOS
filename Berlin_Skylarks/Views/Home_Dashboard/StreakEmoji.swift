//
//  StreakEmoji.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 24.05.22.
//

import SwiftUI

struct StreakEmoji: View {
    
    var emoji: String
    
    var body: some View {
        Section(
            header: Text("Team mood"),
            footer: Text("Clubhouse champagne celebration or dugout fights?")
        ){
            HStack {
                Spacer()
                Text(emoji)
                    .font(.system(size: 90))
                    .padding()
                Spacer()
            }
        }
    }
}

struct StreakEmoji_Previews: PreviewProvider {
    static var previews: some View {
        List {
            StreakEmoji(emoji: "😶")
        }
    }
}
