//
//  TestView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 30.09.21.
//

import SwiftUI
import MapKit

struct TestView: View {
    
    private var pointsOfInterest = [
        AnnotatedItem(name: "Ballpark", coordinate: .init(latitude: (dummyGameScores[3].field?.latitude)!, longitude: (dummyGameScores[3].field?.longitude)!)),
        ]
    
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: (dummyGameScores[3].field?.latitude) as! CLLocationDegrees as! CLLocationDegrees, longitude: (dummyGameScores[3].field?.longitude)!), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    var body: some View {
        NavigationView {
            Text("first layer")
            Text("Second Layer")
            Text("third layer")
        }
    }
    
    //this is how you can declare functions in a view!
    
    private func printSomething() {
        print(self)
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            TestView().preferredColorScheme($0)
        }
.previewInterfaceOrientation(.landscapeLeft)
    }
}
