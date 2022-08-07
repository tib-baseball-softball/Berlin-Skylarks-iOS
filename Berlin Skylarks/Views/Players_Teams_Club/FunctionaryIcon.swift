//
//  FunctionaryIcon.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 05.08.22.
//

import SwiftUI

struct FunctionaryIcon: View {
    var functionary: BSMFunctionary
    
    var body: some View {
        if functionary.function.contains("Abteilungsleit") {
            Image(systemName: "crown")
                .foregroundColor(.skylarksRed)
        } else if functionary.category.contains("Kasse") {
            Image(systemName: "eurosign.circle")
                .foregroundColor(.skylarksRed)
        } else if functionary.function.contains("Schrift") {
            Image(systemName: "pencil.circle")
                .foregroundColor(.skylarksRed)
        } else if functionary.category.contains("Jugend") {
            //iOS 16
            //Image(systemName: "figure.and.child.holdinghands")
            Image(systemName: "person.2")
                .colorDynamicNavySandWatchOS()
        } else if functionary.category.contains("Umpire") {
            Image(systemName: "person")
                .colorDynamicNavySandWatchOS()
        } else if functionary.category.contains("Scorer") {
            Image(systemName: "pencil")
                .colorDynamicNavySandWatchOS()
        } else {
            //fallback image if none apply
            Image(systemName: "person")
                .colorDynamicNavySandWatchOS()
        }
    }
}

struct FunctionaryIcon_Previews: PreviewProvider {
    static var previews: some View {
        FunctionaryIcon(functionary: previewFunctionary)
    }
}
