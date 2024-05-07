//
//  RecipeDetail.swift
//  RecipeBrowser
//
//  Created by Jinho An on 07.05.24.
//

import SwiftUI

struct RecipeDetail: View {
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Recipe Name
                Text(recipe.recipeName)
                    .font(.title)
                    .bold()
                    .foregroundColor(.primary)
                
                // Recipe Image
                AsyncImage(url: URL(string: recipe.photoURLs)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(16)
                            .padding()
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.gray)
                            .cornerRadius(16)
                            .padding()
                    @unknown default:
                        EmptyView()
                    }
                }
                
                // Ingredients
                VStack(alignment: .leading, spacing: 8) {
                    Text("Ingredients:")
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(recipe.ingredients.replacingOccurrences(of: ",", with: ", "))
                        .foregroundColor(.secondary)
                }
                
                // Directions
                VStack(alignment: .leading, spacing: 8) {
                    Text("Directions:")
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(recipe.directions)
                        .foregroundColor(.secondary)
                }
                
                // Author
                Text("By \(recipe.author)")
                    .font(.subheadline)
            }
            .padding()
        }
        .navigationTitle("Recipe Details")
    }
}


#Preview {
    RecipeDetail(recipe: Recipe(id: "1", recipeName: "Egg fried rice", author: "Jinho An", ingredients: "egg,rice,carrot,oil,soy sauce", directions: "Heat a pan or wok over medium-high heat and add a small amount of oil. Pour the beaten eggs into the pan and scramble until fully cooked. Remove from the pan and set aside. Add a bit more oil to the pan and sauté the chopped vegetables until they are tender. Add the cooked rice to the pan and stir-fry with the vegetables for a few minutes. Pour in soy sauce to taste and mix well.", photoURLs: "https://images.unsplash.com/photo-1687020836451-41977907509e?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
)
}
