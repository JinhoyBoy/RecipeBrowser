//
//  MainView.swift
//  RecipeBrowser
//
//  Created by Jinho An on 04.05.24.
//

import SwiftUI

struct MainView: View {
    @StateObject var selection = Selection()
    var body: some View {
        TabView {
            SearchView()
                .environmentObject(selection)
                .tabItem {
                    Label("Ingredients", systemImage: "carrot.fill")
                }
            ContentView()
                .environmentObject(selection)
                .tabItem {
                    Label("Recipes", systemImage: "book.pages.fill")
                }
        }
    }
}

#Preview {
    MainView()
}
