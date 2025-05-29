//
//  DiskImageCache.swift
//  FetchTakeHome
//
//  Created by Mariana Montoya on 5/25/25.
//

import CryptoKit
import Foundation
import UIKit

protocol DiskImageCacheProtocol {
    func image(for url: URL) -> UIImage?
    func storeImage(_ image: UIImage, for url: URL)
}


final class DiskImageCache: DiskImageCacheProtocol  {
    static let shared = DiskImageCache()
    // Using the filesystem in order to access cache
    private let fileManager = FileManager.default
    private let cacheDirectory: URL

    // finds the users caches
    private init() {
        let caches = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        cacheDirectory = caches.appendingPathComponent("ImageCache", isDirectory: true)
        //Put it in the cacheDirectory as this is temp files
        // Use of IntermediateDirectories to ensures it will create any missing parent directories
        try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
    }

    //Image retrival
    func image(for url: URL) -> UIImage? {
        let path = cacheDirectory.appendingPathComponent(hashedFilename(for: url))
        guard fileManager.fileExists(atPath: path.path),
              let data = try? Data(contentsOf: path),
              let image = UIImage(data: data) else {
            return nil
        }
        return image
    }
    // Storing the image
    func storeImage(_ image: UIImage, for url: URL) {
        let path = cacheDirectory.appendingPathComponent(hashedFilename(for: url))
        guard let data = image.pngData() else { return }
        try? data.write(to: path)
    }

    private func hashedFilename(for url: URL) -> String {
        let input = Data(url.absoluteString.utf8)
        // Using SHA1 over SHA256 because from my understanding security is low on this project, if we need to inhance security change to SH256
        let hash = Insecure.SHA1.hash(data: input)
        return hash.compactMap { String(format: "%02x", $0) }.joined()
    }
}


