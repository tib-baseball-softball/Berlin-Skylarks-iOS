//
//  ChartElement.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 23.05.22.
//

import SwiftUI

struct ChartElement: View {
    
    var tableRow: LeagueTable.Row
    
    var height: CGFloat
    
    var body: some View {
        VStack {
            Text("\(tableRow.wins_count)")
            Spacer()
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .foregroundColor(tableRow.team_name.contains("Skylarks") ? Color.skylarksRed : .skylarksDynamicNavySand)
                .frame(maxWidth: 10, minHeight: height)
            if UIDevice.current.userInterfaceIdiom == .phone {
                Text(tableRow.short_team_name)
                    .padding(.top)
            } else if UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.userInterfaceIdiom == .mac {
                Text(tableRow.team_name)
                    .padding(.top)
            }
            
        }
        .frame(height: height + 80)
        .font(.headline)
        .padding(.vertical)
    }
}

struct ChartElement_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ChartElement(tableRow: emptyRow, height: 70)
        }
        .preferredColorScheme(.dark)
    }
}
