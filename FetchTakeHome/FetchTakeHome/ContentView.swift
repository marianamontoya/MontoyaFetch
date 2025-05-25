//
//  ContentView.swift
//  FetchTakeHome
//
//  Created by Mariana Montoya on 5/24/25.
//

import SwiftUI

struct Response: Codable {
    var recipes: [Result]
}

struct Result: Codable, Identifiable {

    let id: String
    let cuisine: String
    let name: String
    let photo_url_large: String
    let photo_url_small: String?
    let source_url: String? // provides errors because some of the urls are missing
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

struct ContentView: View {
    @State private var results = [Result]()
    
    var body: some View {
//        If the recipes list is empty, the app should display
//        an empty state to inform users that no recipes are available.
        if results.isEmpty{
            VStack(alignment: .leading){
                Image(systemName: "exclamationmark.magnifyingglass")
                    .resizable()
                    .scaledToFit()
                
                Text("Sorry for the inconvence, currently there are no recipes avaliable. Please check back soon.")
                    .padding(10)
                    .font(.headline)
                    .fontDesign(.rounded)
                    .foregroundColor(.blue)
                    .ignoresSafeArea()

                
            }
        }
        
        List(results) { item in
            HStack {
                AsyncImage(url: URL(string: item.photo_url_large)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100)
                .cornerRadius(8)

                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    Text(item.cuisine)
                        .font(.caption)
                }
            }
        }
        .task {
            await loadData()
        }
        // Refreshing the data by scrolling down
        .refreshable {
            await loadData()
        }
    }
    
    func loadData() async {
        // 1. Get the URL
        
        guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") else {
            print("Invalid URL")
            return
        }
        
        // 2. Fetch the data
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // 3. Decode that result into a response struct
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.recipes
            }
        } catch {
            print("Decoding failed: \(error)")
        }
    }
}

#Preview {
    ContentView()
}
