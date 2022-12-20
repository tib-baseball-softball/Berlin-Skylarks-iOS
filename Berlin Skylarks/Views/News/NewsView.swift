//
//  TabBarView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 23.12.20.
//

import SwiftUI

//right now all news items lead to the same page
let newsPlaceholder = "Lorem Ipsum"

struct NewsView: View {
    var body: some View {
        NewsBody()
    }
}

struct NewsItem: View {
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: NewsItemSpacing
        ) {
            Image("dummy_field")
                .resizable()
                .scaledToFit()
            Text(newsPlaceholder)
                .font(.title2)
                .bold()
                .padding(.horizontal, 10)
            Text(newsPlaceholder)
                .padding(10)
        }
        .background(ItemBackgroundColor)
        .cornerRadius(NewsItemCornerRadius)
        .padding(NewsItemPadding)
        .foregroundColor(.primary)
        .frame(maxWidth: 330)
    }
}

struct NewsBody: View {
    var body: some View {
        List {
            NavigationLink(
                destination: NewsDetailView()) {
                    NewsItem()
            }
        }
        .navigationTitle("News")
        .listStyle(.inset)
        
        .navigationViewStyle(.stack)
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewsView()
        }
        
    }
}
