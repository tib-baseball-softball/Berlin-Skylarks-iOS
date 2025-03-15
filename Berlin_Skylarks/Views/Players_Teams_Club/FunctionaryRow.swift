//
//  FunctionaryRow.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 05.08.22.
//

import SwiftUI

struct FunctionaryRow: View {
    var functionary: BSMFunctionary
    
    var body: some View {
        HStack {
            FunctionaryIcon(functionary: functionary)
                .clubIconStyleDynamic()
                .padding(.trailing)
            VStack(alignment: .leading) {
                Text(functionary.function)
                    .foregroundColor(.secondary)
                Text("\(functionary.person.last_name), \(functionary.person.first_name)")
                    .bold()
                    //.padding(1)
            }
            .padding(3)
        }
    }
}

struct FunctionaryRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            FunctionaryRow(functionary: previewFunctionary)
        }
    }
}
