//
//  StreakNumberView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 24.05.22.
//

import SwiftUI

struct StreakNumberView: View {
    
    @ObservedObject var userDashboard: UserDashboard
    
    var body: some View {
        Section(
            header: Text("Current Streak")
        ){
            HStack {
                Spacer()
                Text(userDashboard.tableRow.streak)
                    .font(.largeTitle)
                    .bold()
                    .padding()
                Spacer()
            }
        }
    }
}

struct StreakNumberView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            StreakNumberView(userDashboard: dummyDashboard)
        }
    }
}
