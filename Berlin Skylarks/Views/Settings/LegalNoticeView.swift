//
//  LegalNoticeView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 28.04.22.
//

import SwiftUI

struct LegalNoticeView: View {
    var languageCode: String
    
    var body: some View {
        ScrollView {
            let legalNoticeText = MarkdownFile(stringLiteral: "app_impressum_\(languageCode).md")
            Text(legalNoticeText.rawMarkdown ?? "Default Legal Notice text.")
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
        LegalNoticeView(languageCode: "en")
    }
}
