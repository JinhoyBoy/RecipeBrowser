//
//  ContentView.swift
//  RecipeBrowser
//
//  Created by Jinho An on 04.05.24.
//

import SwiftUI
import FirebaseDatabase

struct ContentView: View {
    @State private var ref: DatabaseReference!
    @State private var recipeName = ""
    var body: some View {
        VStack {
            Image(systemName: "carrot.fill")
                .imageScale(.large)
                .foregroundStyle(.orange)
            Text(recipeName)
        }
        .onAppear{
            ref = Database.database().reference()
            ref.child("7000").child("Recipe Name").getData { error, snapshot in
                    if let error = error {
                        print("Error fetching data: \(error)")
                    } else if let value = snapshot?.value as? String {
                        let Name = value
                        print("Recipe Name: \(Name)")
                        recipeName = Name
                    } else {
                        print("Data is not in the expected format.")
                    }
                }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
