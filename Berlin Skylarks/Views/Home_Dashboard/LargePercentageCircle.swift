//
//  LargePercentageCircle.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 14.06.22.
//

import SwiftUI

struct LargePercentageCircle: View {
    
    var percentage: CGFloat
    var percentageText: String
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: percentage)
                .stroke(Color.green, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                .frame(width: 150, height: 150)
                .rotationEffect(.degrees(-90))
                .padding()
            //Text(".136")
            Text(percentageText)
                .font(.title)
                .bold()
        }
    }
}

struct LargePercentageCircle_Previews: PreviewProvider {
    static var previews: some View {
        LargePercentageCircle(percentage: 0.5, percentageText: ".156")
    }
}
