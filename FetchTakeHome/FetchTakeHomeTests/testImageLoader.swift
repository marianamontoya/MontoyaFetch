//
//  testImageLoader.swift
//  FetchTakeHomeTests
//
//  Created by Mariana Montoya on 5/27/25.
//

import XCTest
@testable import FetchTakeHome
// More on this : https://developer.apple.com/documentation/foundation/urlprotocol
final class URLProtocolMock: URLProtocol {
    //Maping our URLS to a dict
    static var testURLs: [URL: Data] = [:]
    
    //Whether the class can init the given request
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    //Return the request as is
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        // Attempts to get request url by checking dict
        if let url = request.url, let data = Self.testURLs[url] {
            // if found signals that is found
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } else {
            // else simulates 404 error
            client?.urlProtocol(self, didFailWithError: NSError(domain: "URLProtocolMock", code: 404))
        }
    }
    
    // Required in the case we need to cancel operation
    override func stopLoading() {
    }
    
}


@MainActor
final class testImageLoader: XCTestCase {
    
    // Happy Path
    func test_successfull_imageLoader() async throws {
        // .expectation used to wait for asynchronous code to complete
        let expectation = self.expectation(description: "Image loaded")
        
        // Mock URL and data
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
        let imageData = UIImage(systemName: "photo")!.pngData()!
        
        //Mapping to the Dictonary
        URLProtocolMock.testURLs = [url: imageData]
        
        // Creating Mock URL session
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        
        // Now using the ImageLoader
        let loader = ImageLoader(session: session)
        loader.load(from: url)
        
        // Checking to see if the image was loaded
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNotNil(loader.image)
            expectation.fulfill()
        }
        // Waiting to see if it was timedout or successful
        await fulfillment(of: [expectation], timeout: 2)
    }
    
    func test_memoryCacheHit() async {
        
        // Checking if URL is valid
        guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg") else {
            XCTFail("Invalid URL")
            return
        }
        
        // Create mock image
        let cacheImage = UIImage(systemName: "photo")!
        
        // adding the image to the cache
        ImageLoader.setMemoryCacheImage(cacheImage, for: url)
        
        // Create a new imageLoader instance
        let loader = ImageLoader()
        
        // Adding url to that new imageLoader
        loader.load(from: url)
        
        // Checking that the two images returned by the loaders match the same image content
        XCTAssertEqual(loader.image?.pngData(), cacheImage.pngData(), "Images should be loaded from cache")
    }
    
}
    
