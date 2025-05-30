//
//  AsyncImageView.swift
//  FetchTakeHome
//
//  Created by Mariana Montoya on 5/25/25.
//

import SwiftUI

struct AsyncImageView: View {
    @StateObject private var loader = ImageLoader()
    let url: URL
    let placeholder: Image

    var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                placeholder
                    .resizable()
            }
        }
        // Adding allows to save effiency for when the user does not directly need it
        .onAppear {
            loader.load(from: url)
        }
        .onDisappear {
            loader.cancel()
        }
    }
}
#Preview {
    AsyncImageView(
        url: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg")!,
        placeholder: Image(systemName: "birthday.cake.fill")
        
    )
    .frame(width: 300, height: 300)
}
