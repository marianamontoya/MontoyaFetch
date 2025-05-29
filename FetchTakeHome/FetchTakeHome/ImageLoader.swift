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
    @Published var error: Error?
    
    // For recently used images
    private static let memoryCache = NSCache<NSURL, UIImage>()
    private var task: URLSessionDataTask?
    private var url: URL?
    
    private let session: URLSession
    private let diskCache: any DiskImageCacheProtocol
    
    // Using for lightweight with ephemeral which has no persistent storage
    init( session: URLSession = .init(configuration: .ephemeral), diskCache: (any DiskImageCacheProtocol)? = nil)
    {
        self.session = session
        self.diskCache = diskCache ?? DiskImageCache.shared

    }
    

    func load(from url: URL) {
        self.url = url
        self.error = nil
        self.image = nil

        // Check memory cache
        if let cached = Self.memoryCache.object(forKey: url as NSURL) {
            self.image = cached
            return
        }

        // Check disk cache if found adds to memory cache
        if let diskCached = diskCache.image(for: url) {
            Self.memoryCache.setObject(diskCached, forKey: url as NSURL)
            self.image = diskCached
            return
        }
        

        // Fetch from network
        task = session.dataTask(with: url) { [weak self] data, _, error in
            guard
                // downloads the image to the background
                let self = self,
                self.url == url,
                let data = data,
                let downloaded = UIImage(data: data),
                error == nil
            else { return }

            Self.memoryCache.setObject(downloaded, forKey: url as NSURL)
            DiskImageCache.shared.storeImage(downloaded, for: url)

            DispatchQueue.main.async {
                self.image = downloaded
            }
        }

        task?.resume()
    }

    func cancel() {
        task?.cancel()
        task = nil
        error = nil
    }
}

// Allows us to access memory cache
#if DEBUG
extension ImageLoader {
    static func setMemoryCacheImage(_ image: UIImage, for url: URL) {
        memoryCache.setObject(image, forKey: url as NSURL)
    }
}
#endif

