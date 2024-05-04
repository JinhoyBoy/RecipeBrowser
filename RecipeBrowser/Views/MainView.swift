//
//  MainView.swift
//  RecipeBrowser
//
//  Created by Jinho An on 04.05.24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Label("Ingredients", systemImage: "carrot.fill")
                }

            ContentView()
                .tabItem {
                    Label("Recipes", systemImage: "book.pages.fill")
                }
        }
    }
}

#Preview {
    MainView()
}
