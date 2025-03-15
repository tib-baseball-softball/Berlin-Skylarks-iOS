//
//  FunctionaryDetailView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 05.08.22.
//

import SwiftUI

struct FunctionaryDetailView: View {
    var functionary: BSMFunctionary

    var body: some View {
        List {
            Section {
                HStack {
                    FunctionaryIcon(functionary: functionary)
                        .clubIconStyleDynamic()
                    Text(functionary.function)
                        .textSelection(.enabled)
                }
                HStack {
                    Image(systemName: "info.circle")
                        .foregroundColor(.secondary)
                        .clubIconStyleDynamic()
                    Text(functionary.category)
                        .foregroundColor(.secondary)
                        .textSelection(.enabled)
                }
            }
            .listRowSeparatorTint(.skylarksSand)
            Section {
                HStack {
                    Image(systemName: "rhombus")
                        .clubIconStyleDynamic()
                    Text(
                        "\(functionary.person.last_name), \(functionary.person.first_name)"
                    )
                    .font(.headline)
                    .padding(.vertical, 1)
                    .textSelection(.enabled)
                }
                let mailtoUrl = URL(string: "mailto:\(functionary.mail)")!

                HStack {
                    Image(systemName: "envelope")
                        .clubIconStyleDynamic()
                    Button(
                        "\(functionary.mail)",
                        action: {
                            #if !os(macOS)
                                if UIApplication.shared.canOpenURL(mailtoUrl) {
                                    UIApplication.shared.open(
                                        mailtoUrl, options: [:])
                                }
                            #endif

                            #if os(macOS)
                                // TODO: send email
                            #endif
                        })
                }

            }
            .listRowSeparatorTint(.skylarksSand)
        }
        .navigationTitle("Contact Details")
    }
}

struct FunctionaryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FunctionaryDetailView(functionary: previewFunctionary)
        }
        .preferredColorScheme(.dark)
    }
}
