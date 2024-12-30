//
//  TrainingListRow.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.12.24.
//

import SwiftUI

struct TrainingListRow: View {
    let training: Components.Schemas.Training

    var body: some View {
        let localizedDay = String.LocalizationValue(
            stringLiteral: training.humanDay ?? "")
        let localizedSeason = String.LocalizationValue(
            stringLiteral: training.humanSeason ?? "")
        let formattedStartTime = DateTimeUtility.formatTime(
            time: training.starttime)
        let formattedEndTime = DateTimeUtility.formatTime(
            time: training.endtime)

        VStack(alignment: .leading, spacing: 10) {
            Text(String(localized: localizedSeason))
                .font(.headline)
            Label(
                "\(String(localized: localizedDay)), \(formattedStartTime) - \(formattedEndTime)",
                systemImage: "calendar.badge.clock")
            Label(training.location, systemImage: "sportscourt")
            if let extra = training.extra {
                if !extra.isEmpty {
                    Label(extra, systemImage: "info.bubble")
                        .foregroundStyle(Color.skylarksDynamicNavySand)
                }
            }
        }
        .font(.callout)
    }
}

#Preview {
    List {
        TrainingListRow(
            training: .init(
                uid: 1, season: ._0, day: ._1, starttime: 62456, endtime: 72456,
                location: "Gail S. Halvorsen Park",
                extra: "Tolles Training zusammen mit Spaß", team: 6,
                teamname: "Team 2",
                humanDay: "Monday", humanSeason: "Winter")
        )
        .padding(.vertical, 10)
        TrainingListRow(
            training: .init(
                uid: 1, season: ._0, day: ._1, starttime: 72456, endtime: 72456,
                location: "Gail S. Halvorsen Park", team: 6, teamname: "Team 2",
                humanDay: "Tuesday", humanSeason: "Winter")
        )
        .padding(.vertical, 10)
        TrainingListRow(
            training: .init(
                uid: 1, season: ._0, day: ._1, starttime: 72456, endtime: 72456,
                location: "Gail S. Halvorsen Park", team: 6, teamname: "Team 2",
                humanDay: "Thursday", humanSeason: "Winter")
        )
        .padding(.vertical, 10)
    }
}
