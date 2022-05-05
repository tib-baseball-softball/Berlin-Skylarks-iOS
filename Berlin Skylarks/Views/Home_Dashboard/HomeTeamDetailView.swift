//
//  HomeTeamDetailView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 18.04.22.
//

import SwiftUI

struct HomeTeamDetailView: View {
    
    @ObservedObject var userDashboard: UserDashboard
    
    var body: some View {
        List {
            Section(
                header: Text("Stuff"),
                footer: Text("more Stuff")
            ){
                Text("Stuff")
            }
        }
    }
}

struct HomeTeamDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTeamDetailView(userDashboard: dummyDashboard)
    }
}
