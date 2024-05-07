//
//  SearchView.swift
//  RecipeBrowser
//
//  Created by Jinho An on 04.05.24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var selectedIngredients = [String]()
    @StateObject private var viewModel = RecipeViewModel()
    @EnvironmentObject private var selection: Selection
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(searchResults, id: \.self) { ingredient in
                        Button(ingredient) {
                            if selectedIngredients.contains(ingredient){

                            } else {
                                addIngredient(ingredient)
                            }
                        }
                    }
                }
                .navigationTitle("Ingredient Browser")
                .onAppear {
                    selectedIngredients = selection.ingredients
                    viewModel.listentoRealtimeDatabase()
                }
                .onDisappear {
                    viewModel.stopListening()
                }
            }
            .searchable(text: $searchText)
            .autocapitalization(.none)
            
            SelectedIngredientsView(selectedIngredients: selectedIngredients, removeIngredient: removeIngredient)
        }
    }

    private func addIngredient(_ ingredient: String) {
        selectedIngredients.append(ingredient)
        selection.ingredients.append(ingredient)
    }

    private func removeIngredient(_ ingredient: String) {
        selectedIngredients.removeAll { $0 == ingredient }
        selection.ingredients = selectedIngredients
    }

    var searchResults: [String] {
        searchText.isEmpty ? viewModel.allUniqueIngredients() :
                             viewModel.allUniqueIngredients().filter { $0.contains(searchText) }
    }
}

struct IngredientRow: View {
    let ingredient: String
    let onDelete: () -> Void

    var body: some View {
        HStack {
            Text(ingredient)
                .foregroundStyle(.white)

            Spacer()

            Button(action: onDelete) {
                Image(systemName: "minus.circle.fill")
                    .foregroundStyle(.white)
            }
        }
        .padding(10)
        .cornerRadius(16)
        .background(RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(.orange))
    }
}


#Preview {
    SearchView().environmentObject(Selection())
}
