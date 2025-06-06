//
//  FunctionaryView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 05.08.22.
//

import SwiftUI

/// Displays a list of club officials (functionaries).
///
/// Allows navigation to detailed information for each official.
struct FunctionaryView: View {
    @ObservedObject var clubData: ClubData

    var body: some View {
        NavigationStack {
            List {
                Section {
                    if clubData.loadingInProgress == true {
                        LoadingView()
                    }
                    ForEach(clubData.functionaries, id: \.id) { functionary in
                        NavigationLink(
                            destination: FunctionaryDetailView(
                                functionary: functionary)
                        ) {
                            FunctionaryRow(functionary: functionary)
                        }
                    }
                    if clubData.loadingInProgress == false
                        && clubData.functionaries.isEmpty
                    {
                        Text("There is no data to display.")
                    }
                }
                .listRowSeparatorTint(.skylarksSand)
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
}

struct FunctionaryView_Previews: PreviewProvider {
    static var previews: some View {
        FunctionaryView(clubData: ClubData())
    }
}
