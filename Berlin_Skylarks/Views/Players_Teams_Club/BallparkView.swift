//
//  BallparkView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 06.08.22.
//

import SwiftUI

struct BallparkView: View {
    @ObservedObject var clubData: ClubData
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(clubData.fieldObjects, id: \.id) { fieldObject in
                        NavigationLink(destination: BallparkDetailView(fieldObject: fieldObject)) {
                            BallparkRow(fieldObject: fieldObject)
                        }
                    }
                }
            }
            .navigationTitle("Ballpark")
            .animation(.default, value: clubData.fieldObjects)
            
            .refreshable {
                await clubData.loadFields()
            }
        }
    }
}

struct BallparkView_Previews: PreviewProvider {
    static var previews: some View {
        BallparkView(clubData: ClubData())
    }
}
