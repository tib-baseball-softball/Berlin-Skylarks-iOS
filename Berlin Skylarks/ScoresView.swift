//
//  ScoresView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 26.12.20.
//

import SwiftUI

struct ScoresListViewHeader: View {
    var body: some View {
        Text("League")
    }
}

struct ScoresView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: ScoresListViewHeader()) {
                    NavigationLink(
                        destination: ScoresDetailView()) {
                            ScoresOverView()
                    }
                }
                
                Section(header: ScoresListViewHeader()) {
                    Text("Result #2")
                }
                
                Section(header: ScoresListViewHeader()) {
                    Text("Result #3")
                }
                
                Section(header: ScoresListViewHeader()) {
                    Text("Result #4")
                }
                
                Section(header: ScoresListViewHeader()) {
                    Text("Result #5")
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Scores")
            .navigationBarItems(leading:
                HStack {
                    Image(systemName: "chevron.backward.circle.fill")
                    Spacer(minLength: 85)
                   // Text("Calendar Week") //this needs to be configured to select the week
                }
                                ,trailing:
                    Image(systemName: "chevron.forward.circle.fill")
            )
        }
    }
}

struct ScoresView_Previews: PreviewProvider {
    static var previews: some View {
        ScoresView()
    }
}
