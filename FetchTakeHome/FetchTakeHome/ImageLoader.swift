//
//  ImageLoader.swift
//  FetchTakeHome
//
//  Created by Mariana Montoya on 5/25/25.
//
import Combine
import CryptoKit
import Foundation
import UIKit

final class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    private static let memoryCache = NSCache<NSURL, UIImage>()
    private static let session = URLSession(configuration: .ephemeral)
    private var task: URLSessionDataTask?
    private var url: URL?

    func load(from url: URL) {
        self.url = url

        // Check memory cache
        if let cached = Self.memoryCache.object(forKey: url as NSURL) {
            self.image = cached
            return
        }

        // Check disk cache
        if let diskCached = DiskImageCache.shared.image(for: url) {
            Self.memoryCache.setObject(diskCached, forKey: url as NSURL)
            self.image = diskCached
            return
        }

        // Fetch from network
        task = Self.session.dataTask(with: url) { [weak self] data, _, error in
            guard
                let self = self,
                self.url == url,
                let data = data,
                let downloaded = UIImage(data: data),
                error == nil
            else { return }

            Self.memoryCache.setObject(downloaded, forKey: url as NSURL)
            DiskImageCache.shared.store(downloaded, for: url)

            DispatchQueue.main.async {
                self.image = downloaded
            }
        }

        task?.resume()
    }

    func cancel() {
        task?.cancel()
        task = nil
    }
}
