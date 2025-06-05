//
//  TableSummarySection.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 02.06.25.
//

import SwiftUI

struct TableSummarySection: View {
    @Environment(HomeViewModel.self) var vm: HomeViewModel
    
    var loadingTables: Bool
    var team: BSMTeam
    var dataset: HomeDataset
    
    var body: some View {
        Section(header: Text("Standings/Record")) {
            if !loadingTables {
                NavigationLink(
                    destination: HomeTeamDetailView(dataset: dataset).environment(vm)
                ) {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "sum")
                                .frame(maxWidth: 20)
                                .foregroundColor(
                                    Color.skylarksAdaptiveBlue)
                            Text(
                                "\(Int(dataset.tableRow.wins_count)) - \(Int(dataset.tableRow.losses_count))"
                            )
                            .bold()
                            .padding(.leading)
                        }
                        Divider()
                        HStack {
                            Image(systemName: "percent")
                                .frame(maxWidth: 20)
                                .foregroundColor(
                                    Color.skylarksAdaptiveBlue)
                            Text(dataset.tableRow.quota)
                                .bold()
                                .padding(.leading)
                        }
                        Divider()
                        HStack {
                            Image(systemName: "number")
                                .frame(maxWidth: 20)
                                .foregroundColor(
                                    Color.skylarksAdaptiveBlue)
                            Text(dataset.tableRow.rank)
                                .bold()
                                .padding(.leading)
                            if dataset.tableRow.rank == "1." {
                                Image(systemName: "crown")
                                    .foregroundColor(Color.skylarksRed)
                            }
                        }
                    }
                    .padding(.vertical, 6)
                }
            }
        }
        
        if !loadingTables {
            NavigationLink(
                destination: StandingsTableView(
                    leagueTable: dataset.leagueTable)
            ) {
                HStack {
                    Image(systemName: "tablecells")
                        .foregroundColor(.skylarksRed)
                    Text(dataset.leagueTable.league_name)
                        .padding(.leading)
                }
            }
        }
        
        if loadingTables == true {
            LoadingView()
        }
    }
}

