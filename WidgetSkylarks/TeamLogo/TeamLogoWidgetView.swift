//
//  TeamLogoWidgetView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 18.10.22.
//

import SwiftUI
import WidgetKit

struct TeamLogoWidgetView: View {
    var entry: TeamLogoProvider.Entry
    
    var body: some View {
        ZStack {
            Color.skylarksRed
            //Text("Logo")
            Image("bird_vec_60")
                .resizable()
                .scaledToFit()
            //this really should be relative
                .frame(width: 46)
                .offset(x: -2)
        }
    }
}

struct TeamLogoWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        TeamLogoWidgetView(entry: LogoEntry(date: .now))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
