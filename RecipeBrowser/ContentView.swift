//
//  ContentView.swift
//  RecipeBrowser
//
//  Created by Jinho An on 04.05.24.
//

import SwiftUI
import FirebaseDatabase

struct ContentView: View {
    @StateObject private var viewModel = RecipeViewModel()
    var body: some View {
        NavigationStack {
            ScrollViewReader { reader in
                List(viewModel.recipes) { recipe in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(recipe.recipeName).font(.title3).bold()
                            Text(recipe.author)
                        }
                        Spacer()
                        AsyncImage(url: URL(string: recipe.photoURLs)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                Rectangle()
                                    .aspectRatio(1, contentMode: .fit)
                                    .overlay(
                                        image.resizable()
                                            .resizable()
                                            .scaledToFill()
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 18.0))
                                    .frame(width: 90, height: 90, alignment: .center)
                            case .failure:
                                Rectangle()
                                    .foregroundStyle(.clear)
                                    .frame(width: 90, height: 90, alignment: .center)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                    
                }
                .onAppear {
                    viewModel.listentoRealtimeDatabase()
                }
                .onDisappear {
                    viewModel.stopListening()
                }
            }
            .navigationTitle("Baking Browser")
        }
    }
}

#Preview {
    ContentView()
}
