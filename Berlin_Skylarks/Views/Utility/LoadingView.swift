//
//  LoadingView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 02.06.22.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        HStack {
            Spacer()
            ProgressView("Loading data...")
            Spacer()
        }
    }
}

#Preview {
    LoadingView()
}
