//
//  PrivacyPolicyView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 28.04.22.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            Text(privacyPolicyText)
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
        PrivacyPolicyView()
    }
}
