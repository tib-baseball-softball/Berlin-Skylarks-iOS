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
                .foregroundColor(.skylarksDynamicNavySand)
        } else if functionary.category.contains("Umpire") {
            Image(systemName: "person")
                .foregroundColor(.skylarksDynamicNavySand)
        } else if functionary.category.contains("Scorer") {
            Image(systemName: "pencil")
                .foregroundColor(.skylarksDynamicNavySand)
        } else {
            //fallback image if none apply
            Image(systemName: "person")
                .foregroundColor(.skylarksDynamicNavySand)
        }
    }
}

struct FunctionaryIcon_Previews: PreviewProvider {
    static var previews: some View {
        FunctionaryIcon(functionary: previewFunctionary)
    }
}
