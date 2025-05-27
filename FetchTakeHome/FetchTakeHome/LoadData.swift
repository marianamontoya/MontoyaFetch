//
//  LoadData.swift
//  FetchTakeHome
//
//  Created by Mariana Montoya on 5/26/25.
//

import Foundation

struct LoadData {
    static func loadData(from url: URL) async throws -> [Recipe] {
        // Load in URL from func
        let (data, _) = try await URLSession.shared.data(from: url)
        // Decode that response into a struct
        let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
        return decodedResponse.recipes
    }
}

