//
//  TrainingSheet.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 08.01.25.
//

import SwiftUI

struct TrainingSheet: View {
    var trainings: [Components.Schemas.Training] = []
    
    var body: some View {
        List {
            Section(header: Text("Practice Times")) {
                ForEach(trainings, id: \.uid) { training in
                    TrainingListRow(training: training)
                }
                #if !os(watchOS)
                .textSelection(.enabled)
                #endif
            }
        }
    }
}

#Preview {
    TrainingSheet()
}
