//
//  TestView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.09.21.
//

import SwiftUI
import MapKit

struct TestView: View {

    //var gamescore: GameScore
    
    @Environment(\.colorScheme) var colorScheme
    
    enum SegmentPicker: String, Identifiable, CaseIterable {
        case option1
        case option2
        var displayName: String { rawValue.capitalized }
        var id: String { self.rawValue }
    }
    
    @State var someBool = false
    @State var selection = SegmentPicker.option1
    
    var body: some View {
        
        List {
            Section {
                Picker(
                    selection: $selection,
                    //this actually does not show the label, just the selection
                    label: HStack {
                        Text("Show:")
                        //Text(selection)
                    },
                    content: {
                        ForEach(SegmentPicker.allCases) { gameday in
                            Text(gameday.displayName)
                            .tag(gameday)
                        }
                        
                })
                .pickerStyle(.segmented)
                Toggle("some Bool", isOn: $someBool)
            }
            .offset(x: 0, y: 0)
            Section {
                Text("blurb")
            }
            Section {
                Text("sdfnbgfjv")
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .principal) {
                VStack {
                    Picker(
                        selection: $selection,
                        //this actually does not show the label, just the selection
                        label: HStack {
                            Text("Show:")
                            //Text(selection)
                        },
                        content: {
                            ForEach(SegmentPicker.allCases) { gameday in
                                Text(gameday.displayName)
                                .tag(gameday)
                            }
                            
                    })
                    .pickerStyle(.segmented)
                    Toggle("some Bool", isOn: $someBool)
                }
            }
        }
//        Group {
//#if !os(watchOS)
//        Text("This is non-watchOS text")
//#else
//        Text("This text appears only on Watch")
//#endif
//        }
//        //this modifier is supposed to work for both platforms
//            .onAppear(perform: {
//                print("this is a pointless message")
//            })
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TestView()
        }
            //.preferredColorScheme(.dark)
            //.previewInterfaceOrientation(.landscapeLeft)
    }
}
