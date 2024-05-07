//
//  SelectedIngredientsView.swift
//  RecipeBrowser
//
//  Created by Jinho An on 07.05.24.
//

import SwiftUI

struct SelectedIngredientsView: View {
    let selectedIngredients: [String]
    let removeIngredient: (String) -> Void

    var body: some View {
        ScrollView {
            VStack {
                if !selectedIngredients.isEmpty{
                    Text("Your Ingredients:")
                        .bold()
                        .foregroundStyle(.orange)
                }
                ForEach(selectedIngredients, id: \.self) { ingredient in
                    IngredientRow(ingredient: ingredient) {
                        removeIngredient(ingredient)
                    }
                }
                .padding(.horizontal, 70)
            }
        }
        .frame(maxHeight: {
            switch selectedIngredients.count {
            case 0:
                return 0
            case 1:
                return 100 // Adjust the height for one ingredient
            case 2:
                return 150 // Adjust the height for two ingredients
            default:
                return 200 // Default height for more than two ingredients
            }
        }())    }
    
}

//#Preview {
//    SelectedIngredientsView(selectedIngredients: [], removeIngredient: removeIngredient)
//}
