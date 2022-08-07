//
//  LicenseSportIndicator.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 05.08.22.
//

import SwiftUI

struct LicenseSportIndicator: View {
    //this view can never have both
    var baseball: Bool
    
    var body: some View {
        if baseball == true {
            ZStack {
                Image(systemName: "circle.fill")
#if !os(watchOS)
                .font(.title)
#else
                .font(.title2)
#endif
                    .foregroundColor(.skylarksRed)
                Text("BB")
                    .bold()
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .semibold))
            }
        } else {
            ZStack {
                Image(systemName: "circle.fill")
#if !os(watchOS)
                .font(.title)
#else
                .font(.title2)
#endif
                    .foregroundColor(.skylarksDynamicNavySand)
                Text("SB")
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .semibold))
            }
        }
    }
}

struct LicenseSportIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LicenseSportIndicator(baseball: false)
    }
}
