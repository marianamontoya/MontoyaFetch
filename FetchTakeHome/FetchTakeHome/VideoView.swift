//
//  VideoView.swift
//  FetchTakeHome
//
//  Created by Mariana Montoya on 5/25/25.
//

import SwiftUI
import WebKit

struct VideoView: UIViewRepresentable {
    
    let videoID: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)") else { return }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: youtubeURL))
    }
}

#Preview {
    VideoView(videoID: "https://www.youtube.com/watch?v=6R8ffRRJcrg")
}
