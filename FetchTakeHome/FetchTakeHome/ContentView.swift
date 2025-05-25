//
//  ContentView.swift
//  FetchTakeHome
//
//  Created by Mariana Montoya on 5/24/25.
//

import SwiftUI

struct ContentView: View {
    @State private var results = [Recipe]()
    
    
    var body: some View {
        Text("Recipe App")
            .font(.largeTitle)
        
        //        If the recipes list is empty, the app should display
        //        an empty state to inform users that no recipes are available.
        if results.isEmpty{
            VStack(alignment: .leading){
                Image(systemName: "exclamationmark.magnifyingglass")
                    .resizable()
                    .scaledToFit()
                
                Text("Sorry for the inconvenience, currently there are no recipes available. Please check back soon.")
                    .padding(10)
                    .font(.headline)
                    .fontDesign(.rounded)
                    .foregroundColor(.blue)
                    .ignoresSafeArea()
                
                
            }
        }
        
        
        // List of Recipes
        NavigationStack {
            List(results) { item in
                NavigationLink {
                    RecipeView(recipe: item)
                } label: {
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
            }
            .task {
                await loadData()
            }
            // Refreshing the data by scrolling down
            .refreshable {
                await loadData()
            }
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
