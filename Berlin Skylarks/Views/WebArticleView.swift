//
//  WebArticleView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 06.07.21.
//
// stolen from https://benoitpasquier.com/create-webview-in-swiftui/

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    typealias UIViewType = WKWebView

    let webView: WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) { }
}

class WebViewModel: ObservableObject {
    let webView: WKWebView
    let url: URL
    
    init() {
        webView = WKWebView(frame: .zero)
        url = URL(string: "https://www.tib-baseball.de/team-3-haelt-die-serie")!

        loadUrl()
    }
    
    func loadUrl() {
        webView.load(URLRequest(url: url))
    }
}


struct WebArticleView: View {
    
    @StateObject var model = WebViewModel()
    
    var body: some View {
        WebView(webView: model.webView)
    }
}

struct WebArticleView_Previews: PreviewProvider {
    static var previews: some View {
        WebArticleView()
    }
}
