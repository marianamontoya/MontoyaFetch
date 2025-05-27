//
//  ContentView.swift
//  FetchTakeHome
//
//  Created by Mariana Montoya on 5/24/25.
//

import SwiftUI

struct ContentView: View {
    @State private var results = [Recipe]()
    @State private var searchText = ""
    
    var filteredResults: [Recipe] {
        if searchText.isEmpty {
            return results
        } else {
            return results.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.cuisine.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            Text("Recipe App")
                .font(.custom("AmericanTypewriter", size: 50))
                .fontWeight(.bold)
            Link(destination: URL(string: "https://www.linkedin.com/in/-marianamontoya/")!) {
                Text("By: Mariana Montoya")
                    .font(.custom("AmericanTypewriter", size: 20))
                    .foregroundColor(.black)
            }
            
            TextField("Search by Recipe Name or Cuisine Type", text: $searchText)
                .font(.custom("AmericanTypewriter", size: 15))
                .textFieldStyle(.automatic)
                .padding(.all)

            //  If the recipes list is empty, the app should display:
            if results.isEmpty{
                VStack(alignment: .leading){
                    Image(systemName: "exclamationmark.magnifyingglass")
                        .resizable()
                        .scaledToFit()
        
                    //  an empty state to inform users that no recipes are available.
                    Text("Sorry for the inconvenience, currently there are no recipes available. Please check back soon.")
                        .padding(10)
                        .font(.headline)
                        .fontDesign(.rounded)
                        .foregroundColor(.blue)
                        .ignoresSafeArea()
                }
            }
            // List of Recipes
            List(filteredResults, id: \.id) { item in
                NavigationLink {
                    RecipeView(recipe: item)
                } label: {
                    HStack {
                        AsyncImageView(
                            url: URL(string: item.photo_url_large)!,
                            placeholder: Image(systemName: "birthday.cake.fill")
                        )
                        .frame(width: 100, height: 100)
                        .cornerRadius(8)
                        
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.custom("AmericanTypewriter", size: 20))
                            Text("Cuisine: \(item.cuisine)")
                                .font(.custom("AmericanTypewriter", size: 15))
                            
                        }
                    }
                }
            }

            .task {
                await loadRecipes()
            }
            // Refreshing the data by scrolling down
            .refreshable {
                await loadRecipes()
            }
        }
    }
            func loadRecipes() async {
                if let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") {
                    do {
                        results = try await LoadData.loadData(from: url)
                    } catch {
                        print("Error loading recipes: \(error.localizedDescription)")
                        results = []
                    }
                }
        }
}

#Preview {
    ContentView()
}
