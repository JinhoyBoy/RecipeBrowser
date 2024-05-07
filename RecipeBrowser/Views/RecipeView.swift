//
//  ContentView.swift
//  RecipeBrowser
//
//  Created by Jinho An on 04.05.24.
//

import SwiftUI

struct RecipeView: View {
    @StateObject private var viewModel = RecipeViewModel()
    @State private var selectedIngredients = [String]()
    @State private var filterIngredients: Set = [""]
    @State private var selectedRecipe: Recipe?
    @EnvironmentObject private var selection: Selection
    var body: some View {
        NavigationView {
            ScrollViewReader { reader in
                if selectedIngredients.isEmpty {
                    Text("No ingredients selected, listing all recipes.")
                        .padding(.top, 5).font(.caption).foregroundStyle(.gray)
                    List(viewModel.recipes) { recipe in
                        Button(action: {
                            selectedRecipe = recipe
                        }) {
                            RecipeRow(recipe: recipe)
                        }
                    }
                } else if (viewModel.recipes.filter { recipe in
                    containsFilterIngredients(recipe.ingredients)
                }).isEmpty{
                    Text("No recipes with your ingredients, listing recipes you can make with one more Ingredient.")
                        .padding(.top, 5).padding(.horizontal).font(.caption).foregroundStyle(.gray)
                    List(viewModel.recipes.filter { recipe in
                        containsFilterIngredientsExeptOne(recipe.ingredients)
                    }) { recipe in
                        Button(action: {
                            selectedRecipe = recipe
                        }) {
                            RecipeRow(recipe: recipe)
                        }
                    }
                } else {
                    Text("Listing recipes with your Ingredients!")
                        .padding(.top, 5).font(.caption).foregroundStyle(.gray)
                    List(viewModel.recipes.filter { recipe in
                        containsFilterIngredients(recipe.ingredients)
                    }) { recipe in
                        Button(action: {
                            selectedRecipe = recipe
                        }) {
                            RecipeRow(recipe: recipe)
                        }
                    }
                }
                
                SelectedIngredientsView(selectedIngredients: selectedIngredients, removeIngredient: removeIngredient)
            }
            .onAppear {
                viewModel.listentoRealtimeDatabase()
                selectedIngredients = selection.ingredients
                filterIngredients = Set(selectedIngredients)
            }
            .onDisappear {
                viewModel.stopListening()
            }
            .navigationTitle("Recipe Browser")
            .sheet(item: $selectedRecipe) { recipe in
                RecipeDetail(recipe: recipe)
            }
        }
    }
    
    private func removeIngredient(_ ingredient: String) {
        selection.ingredients = selection.ingredients.filter { $0 != ingredient }
        selectedIngredients.removeAll { $0 == ingredient }
        filterIngredients = Set(selectedIngredients)
    }
    private func containsFilterIngredients(_ ingredients: String) -> Bool {
        let recipeIngredients = Set(ingredients.components(separatedBy: ","))
        return filterIngredients.isSuperset(of: recipeIngredients)
    }
    private func containsFilterIngredientsExeptOne(_ ingredients: String) -> Bool {
        let recipeIngredients = Set(ingredients.components(separatedBy: ","))
        let combinedIngredients = Set(selectedIngredients).union(recipeIngredients)
        if combinedIngredients.count == selectedIngredients.count + 1 {
            return true
        } else {
            return false
        }
    }
}

struct RecipeRow: View {
    let recipe: Recipe
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(recipe.recipeName)
                    .font(.title3)
                    .bold()
                Text(recipe.author)
            }
            Spacer()
            AsyncImage(url: URL(string: recipe.photoURLs)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 90, height: 90)
                        .clipShape(RoundedRectangle(cornerRadius: 18.0))
                case .failure:
                    Rectangle()
                        .foregroundStyle(.clear)
                        .frame(width: 90, height: 90)
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    RecipeView().environmentObject(Selection())
}
