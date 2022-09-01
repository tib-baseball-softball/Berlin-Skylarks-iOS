//
//  SegmentPercentage.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 23.05.22.
//

import SwiftUI

struct SegmentPercentage: View {
    
    @ObservedObject var userDashboard: UserDashboard
    
    private func getPercentage() -> CGFloat {
        let percentage = CGFloat((userDashboard.tableRow.quota as NSString).floatValue)
        return percentage
    }
    
    var body: some View {
        Section(
            header: Text("Rank")
            //footer: Text("more Stuff")
        ){
            HStack {
                Spacer()
                if userDashboard.tableRow.rank == "1." {
                    Image(systemName: "crown")
                        .foregroundColor(Color.skylarksRed)
                        .padding(.horizontal)
                }
                Text("\(userDashboard.tableRow.rank)")
                    .bold()
                    .padding(.horizontal)
                Spacer()
            }
            .padding()
            .font(.largeTitle)
        }
        Section(
            header: Text("Wins/Losses")
            //footer: Text("more Stuff")
        ){
            HStack {
                Spacer()
                Text("\(Int(userDashboard.tableRow.wins_count))")
                    .bold()
                    .padding(.horizontal)
                Text("-")
                    .bold()
                Text("\(Int(userDashboard.tableRow.losses_count))")
                    .bold()
                    .padding(.horizontal)
                Spacer()
            }
            .font(.largeTitle)
            .padding()
        }
        let percentage = getPercentage()
        Section(
            header: Text("Winning Percentage")
            //footer: Text("more Stuff")
        ){
            HStack {
                Spacer()
                LargePercentageCircle(percentage: percentage, percentageText: userDashboard.tableRow.quota)
                Spacer()
            }
        }
    }
}

struct SegmentPercentage_Previews: PreviewProvider {
    static var previews: some View {
        List {
            SegmentPercentage(userDashboard: dummyDashboard)
        }
        //.preferredColorScheme(.dark)
        //.previewInterfaceOrientation(.landscapeLeft)
    }
}
