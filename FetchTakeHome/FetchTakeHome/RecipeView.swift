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
    
    // In order to dismiss the back button view
    @Environment(\.dismiss) var dismiss
    
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
                
                Text("Cuisine Type:")
                    .font(.custom("AmericanTypewriter", size: 50))
                
                Text(recipe.cuisine)
                    .font(.custom("AmericanTypewriter", size: 50))
                
                if let urlString = recipe.source_url,
                   let url = URL(string: urlString) {
                    Link(destination: url, label: {
                        Label("Recipe's Website", systemImage: "fork.knife")
                            .frame(width: 250, height: 40)
                            .background(.black)
                            .foregroundColor(.white)
                            .padding()
                    })
                    
                    ShareLink(item: url) {
                        Label("Share Recipe", systemImage: "square.and.arrow.up")
                            .frame(width: 250, height: 40)
                            .background(.black)
                            .foregroundColor(.white)
                            .padding()
                    }

                } else {
                    Text("Recipe source not available")
                }
                
            }
            .navigationBarBackButtonHidden(true)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "arrow.left")
                                .foregroundColor(.white)
                            Text("Back")
                                .font(.custom("AmericanTypewriter", size: 15))
                                .fontWeight(.bold)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Capsule().fill(Color.black))
                        .foregroundColor(.white)
                    }
                }
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
        id: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
        cuisine: "Malaysian",
        name: "Apam Balik",
        photo_url_large: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
        photo_url_small: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
        source_url: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
        youtube_url: "https://www.youtube.com/watch?v=6R8ffRRJcrg"
    )
    return RecipeView(recipe: sampleRecipe)
}
