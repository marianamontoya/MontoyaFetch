//
//  testLoadData.swift
//  FetchTakeHomeTests
//
//  Created by Mariana Montoya on 5/26/25.
//

import XCTest
@testable import FetchTakeHome

final class testLoadData: XCTestCase {
    
    // Happy Path Test
    
    func test_successfull_load_data() async throws {
        // Given (Arrange)
        guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") else {
            XCTFail( "Invalid URL" )
            return
        }
        
        // When (Act)
        do {
            let recipes = try await LoadData.loadData(from: url)
            
            // Then (Assert)
            XCTAssertFalse(recipes.isEmpty, "Recipes array should not be empty")
            XCTAssertNotNil(recipes.first?.name, "First item should be a naame")
        } catch {
            XCTFail( "Error loading data: \(error.localizedDescription)")
            
        }
    }
    
    func test_load_data_from_invalid_url() async {
        // Given (Arrange)
        let url = URL(string: "https://invalid/recipes-malformed.json")!
        
        // When (Act)
        do {
            _ = try await LoadData.loadData(from: url)
            // Then (Assert)
            XCTFail("Expected failure from invalid URL, but succeeded.")
        } catch {
            XCTAssertTrue(true)
        }
    }

}
