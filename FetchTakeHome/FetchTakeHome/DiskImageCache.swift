//
//  DiskImageCache.swift
//  FetchTakeHome
//
//  Created by Mariana Montoya on 5/25/25.
//

import Foundation
import UIKit
import CryptoKit


final class DiskImageCache {
    static let shared = DiskImageCache()
    private let fileManager = FileManager.default
    private let cacheDirectory: URL

    private init() {
        let caches = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        cacheDirectory = caches.appendingPathComponent("ImageCache", isDirectory: true)
        try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
    }

    func image(for url: URL) -> UIImage? {
        let path = cacheDirectory.appendingPathComponent(hashedFilename(for: url))
        guard fileManager.fileExists(atPath: path.path),
              let data = try? Data(contentsOf: path),
              let image = UIImage(data: data) else {
            return nil
        }
        return image
    }

    func store(_ image: UIImage, for url: URL) {
        let path = cacheDirectory.appendingPathComponent(hashedFilename(for: url))
        guard let data = image.pngData() else { return }
        try? data.write(to: path)
    }

    private func hashedFilename(for url: URL) -> String {
        let input = Data(url.absoluteString.utf8)
        let hash = SHA256.hash(data: input)
        return hash.compactMap { String(format: "%02x", $0) }.joined()
    }
}
