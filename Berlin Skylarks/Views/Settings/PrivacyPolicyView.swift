//
//  PrivacyPolicyView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 28.04.22.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var languageCode: String
    
    var body: some View {
        ScrollView {
            let privacyPolicyText = MarkdownFile(stringLiteral: "app_pp_\(languageCode).md")
            
            Text(try! AttributedString(markdown: privacyPolicyText.rawMarkdown ?? "Default Privacy Policy text.", options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
#if !os(watchOS)
            .textSelection(.enabled)
#endif
            .padding()
        }
        .navigationTitle("Privacy Policy")
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView(languageCode: "de")
    }
}
