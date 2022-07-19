//
//  ClubDetailView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 19.07.22.
//

import SwiftUI

struct ClubDetailView: View {
    
    @ObservedObject var clubData: ClubData
    
    var body: some View {
        Text(clubData.club.successes)
    }
}

struct ClubDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ClubDetailView(clubData: ClubData())
    }
}
