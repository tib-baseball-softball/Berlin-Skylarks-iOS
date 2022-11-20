//
//  LegalNoticeView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 28.04.22.
//

import SwiftUI

struct LegalNoticeView: View {
    var body: some View {
        ScrollView {
            Text(legalNoticeText)
            #if !os(watchOS)
            .textSelection(.enabled)
            #endif
            .padding()
        }
        .navigationTitle("Legal Notice")
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        LegalNoticeView()
    }
}
