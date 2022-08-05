//
//  FunctionaryView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 05.08.22.
//

import SwiftUI

struct FunctionaryView: View {
    @ObservedObject var clubData: ClubData
    
    var body: some View {
        List {
            Section {
                if clubData.loadingInProgress == true {
                    LoadingView()
                }
                ForEach(clubData.functionaries, id: \.id) { functionary in
                    NavigationLink(destination: FunctionaryDetailView(functionary: functionary)) {
                        FunctionaryRow(functionary: functionary)
                    }
                }
                if clubData.loadingInProgress == false && clubData.functionaries.isEmpty {
                    Text("There is no data to display.")
                }
            }
#if !os(watchOS)
            .listRowSeparatorTint(.skylarksSand)
#endif
        }
        .navigationTitle("Club Officials")
        .animation(.default, value: clubData.functionaries)
        
        .refreshable {
            clubData.functionaries = []
            await clubData.loadFunctionaries()
        }
        
        .onAppear {
            if clubData.functionaries.isEmpty {
                Task {
                    await clubData.loadFunctionaries()
                }
            }
        }
    }
}

struct FunctionaryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FunctionaryView(clubData: ClubData())
        }
    }
}
