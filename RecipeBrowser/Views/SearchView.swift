//
//  SearchView.swift
//  RecipeBrowser
//
//  Created by Jinho An on 04.05.24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    let ingredients = ["Eggs", "Flour", "Sugar", "Butter"]
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { ingredient in
                    NavigationLink {
                        Text(ingredient)
                    } label: {
                        Text(ingredient)
                    }
                }
            }
            .navigationTitle("Baking Browser")
        }
        .searchable(text: $searchText)
    }

    var searchResults: [String] {
        if searchText.isEmpty {
            return ingredients
        } else {
            return ingredients.filter { $0.contains(searchText) }
        }
    }
}

#Preview {
    SearchView()
}
