//
//  SearchView.swift
//  RecipeBrowser
//
//  Created by Jinho An on 04.05.24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var selectedIngredients = ["eggs", "tomato", "pasta"]
    @StateObject private var viewModel = RecipeViewModel()
    var body: some View {
        VStack{
            NavigationStack {
                List{
                    ForEach(searchResults, id: \.self) { ingredient in
                        Text(ingredient)
                    }
                    //                ForEach(allUniqueIngredients(), id: \.self) { ingredient in
                    //                    Text(ingredient)
                    //                }
                }
                .navigationTitle("Recipe Browser")
                .onAppear{
                    viewModel.listentoRealtimeDatabase()
                }
                .onDisappear{
                    viewModel.stopListening()
                }
            }
            .searchable(text: $searchText)
            .autocapitalization(.none)
            VStack{
                Text("Your Ingredients:").bold().foregroundStyle(.orange)
                ForEach(selectedIngredients, id: \.self) { ingredient in
                    HStack {
                        Text(ingredient)
                            .foregroundStyle(.white)
                        Spacer()
                        Button {
                                    print("Image tapped!")
                                } label: {
                                    Image(systemName: "minus.circle")
                                        .foregroundStyle(.white)
                                }
                    }
                    .padding(10)
                    .cornerRadius(16)
                    .background(RoundedRectangle(cornerRadius: 16)
                      .foregroundColor(.orange)
                    )
                }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 70)
            }
            .padding(.bottom)
        }
    }
    var searchResults: [String] {
        if searchText.isEmpty {
            return allUniqueIngredients()
        } else {
            return allUniqueIngredients().filter { $0.contains(searchText) }
        }
    }
    func allUniqueIngredients() -> [String] {
        var allIngredients: [String] = []
        for recipe in viewModel.recipes {
            allIngredients += recipe.ingredients.components(separatedBy: ",")
        }
        let uniqueIngredients = Array(Set(allIngredients.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }))
        var sortedIngredients = uniqueIngredients.sorted()
        sortedIngredients = sortedIngredients.filter { !containsNumbers($0) && !containsUppercaseLetters($0) && !$0.isEmpty}
        return sortedIngredients
    }
    private func containsNumbers(_ string: String) -> Bool {
        return string.rangeOfCharacter(from: .decimalDigits) != nil
    }
    private func containsUppercaseLetters(_ string: String) -> Bool {
        return string.rangeOfCharacter(from: .uppercaseLetters) != nil
    }
}

#Preview {
    SearchView()
}
