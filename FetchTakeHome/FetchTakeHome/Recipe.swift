//
//  Recipe.swift
//  FetchTakeHome
//
//  Created by Mariana Montoya on 5/24/25.
//

import Foundation

struct Response: Codable {
    var recipes: [Recipe]
}

struct Recipe: Codable, Identifiable {

    let id: String
    let cuisine: String
    let name: String
    let photo_url_large: String
    let photo_url_small: String?
    let source_url: String?
    let youtube_url: String? // Reasoning behind making it optional
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name
        case cuisine
        case photo_url_large
        case photo_url_small
        case source_url
        case youtube_url
    }
    
}
