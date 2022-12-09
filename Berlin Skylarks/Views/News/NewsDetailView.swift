//
//  NewsDetailView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 25.12.20.
//

import SwiftUI

let DetailViewPadding: CGFloat = 25
let SmallPaddingCategoryAuthor: CGFloat = 10

struct NewsDetailView: View {
    var body: some View {
        Text(newsPlaceholder)
        .navigationBarTitle("Article", displayMode: .inline)
    }
}

struct NewsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetailView()
    }
}
