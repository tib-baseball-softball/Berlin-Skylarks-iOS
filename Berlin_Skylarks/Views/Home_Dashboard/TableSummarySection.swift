//
//  TableSummarySection.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 02.06.25.
//

import SwiftUI

struct TableSummarySection: View {
    var showingTableData: Bool
    var loadingTables: Bool
    var team: BSMTeam
    var table: LeagueTable
    var userDashboard: UserDashboard
    
    var body: some View {
        let row = determineTableRow(team: team, table: table)
        
        Section(header: Text("Standings/Record")) {
            if showingTableData && !loadingTables {
                NavigationLink(
                    destination: HomeTeamDetailView(
                        userDashboard: userDashboard)
                ) {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "sum")
                                .frame(maxWidth: 20)
                                .foregroundColor(
                                    Color.skylarksAdaptiveBlue)
                            Text(
                                "\(Int(row.wins_count)) - \(Int(row.losses_count))"
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
                            Text(row.quota)
                                .bold()
                                .padding(.leading)
                        }
                        Divider()
                        HStack {
                            Image(systemName: "number")
                                .frame(maxWidth: 20)
                                .foregroundColor(
                                    Color.skylarksAdaptiveBlue)
                            Text(row.rank)
                                .bold()
                                .padding(.leading)
                            if row.rank == "1." {
                                Image(systemName: "crown")
                                    .foregroundColor(Color.skylarksRed)
                            }
                        }
                    }
                    .padding(.vertical, 6)
                }
            }
            
            if !loadingTables {
                NavigationLink(
                    destination: StandingsTableView(
                        leagueTable: table)
                ) {
                    HStack {
                        Image(systemName: "tablecells")
                            .foregroundColor(.skylarksRed)
                        Text(table.league_name)
                            .padding(.leading)
                    }
                }
            }
            if loadingTables == true {
                LoadingView()
            }
        }
    }
}

#Preview {
    TableSummarySection(showingTableData: true, loadingTables: true, team: emptyTeam, table: emptyTable, userDashboard: UserDashboard())
}
