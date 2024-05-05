//
//  ContentView.swift
//  RecipeBrowser
//
//  Created by Jinho An on 04.05.24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RecipeViewModel()
    @State private var selectedIngredients = [String]()
    @EnvironmentObject private var selection: Selection

    var body: some View {
        NavigationView {
            ScrollViewReader { reader in
                List(viewModel.recipes) { recipe in
                    RecipeRow(recipe: recipe)
                }
                .onAppear {
                    viewModel.listentoRealtimeDatabase()
                    selectedIngredients = selection.ingredients
                }
                .onDisappear {
                    viewModel.stopListening()
                }
                
                VStack {
                    Text("Your Ingredients:")
                        .bold()
                        .foregroundStyle(.orange)
                    
                    ForEach(selectedIngredients, id: \.self) { ingredient in
                        IngredientRow(ingredient: ingredient) {
                            removeIngredient(ingredient)
                        }
                    }
                    .padding(.horizontal, 70)
                }
                .padding(.bottom)
            }
            .navigationTitle("Recipe Browser")
        }
    }

    private func removeIngredient(_ ingredient: String) {
        selection.ingredients = selection.ingredients.filter { $0 != ingredient }
        selectedIngredients.removeAll { $0 == ingredient }
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
    ContentView().environmentObject(Selection())
}
