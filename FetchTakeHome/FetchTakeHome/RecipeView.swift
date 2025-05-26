//
//  RecipeView.swift
//  FetchTakeHome
//
//  Created by Mariana Montoya on 5/24/25.
//

import SwiftUI

struct RecipeView: View {
    let recipe: Recipe
    let captionText: String
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                AsyncImage(url: URL(string: recipe.photo_url_large)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 400)
                        .overlay(alignment: .bottom) {
                            CaptionView(text: recipe.name)
                        }
                    
                } placeholder: {
                    ProgressView()
                }

                Text(recipe.name)
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding()
                
                if let urlString = recipe.source_url,
                   let url = URL(string: urlString) {
                    Link("Checkout the Recipe", destination: url)
                } else {
                    Text("Recipe source not available")
                }
                
//                VideoView(videoID: recipe.youtube_url!)
        
            }
        }
        .ignoresSafeArea(edges: .top)
    }
    
    init(recipe: Recipe) {
        self.recipe = recipe
        self.captionText = recipe.name
    }
}



#Preview {
    let sampleRecipe = Recipe(
        id: "1234",
        cuisine: "Malaysian",
        name: "Apam Balik",
        photo_url_large: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
        photo_url_small: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
        source_url: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
        youtube_url: "https://www.youtube.com/watch?v=6R8ffRRJcrg"
    )
    return RecipeView(recipe: sampleRecipe)
}
