//
//  RecipeDetail.swift
//  RecipeBrowser
//
//  Created by Jinho An on 07.05.24.
//

import SwiftUI

struct RecipeDetail: View {
    @StateObject private var viewModel = RecipeViewModel()
        var body: some View {
            VStack {
                ForEach(viewModel.recipes) { recipe in
                    RecipeRow(recipe: recipe)
                }
            }.onAppear {
                viewModel.listentoRealtimeDatabase()
            }
            .onDisappear {
                viewModel.stopListening()
            }
        }
}

#Preview {
    RecipeDetail()
}
