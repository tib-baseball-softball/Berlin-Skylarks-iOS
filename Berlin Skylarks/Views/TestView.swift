//
//  TestView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.09.21.
//

import SwiftUI
import MapKit

struct TestView: View {

    @State var destinations = ["First", "Second", "Third"]
    
    var body: some View {
        ZStack {
            Color(.secondarySystemBackground)
            List {
                Section {
                    NavigationLink(destination: Text("top item detail")) {
                        Text("Top item")
                    }
                }
                Section {
                    ForEach(destinations, id: \.self) { destination in
                        NavigationLink(destination: Text("Detail for \(destination)")) {
                            Text(destination)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationSplitView {
            Text("some stuff")
        } content: {
            TestView()
        } detail:{
            Text("details here")
        }
    }
}
