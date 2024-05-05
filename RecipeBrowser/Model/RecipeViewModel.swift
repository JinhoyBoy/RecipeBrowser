//
//  RecipeViewModel.swift
//  RecipeBrowser
//
//  Created by Jinho An on 04.05.24.
//

import Foundation
import FirebaseDatabase
 
class RecipeViewModel: ObservableObject {
     
    @Published var recipes: [Recipe] = []
     
    private lazy var databasePath: DatabaseReference? = {
            let ref = Database.database().reference()
            return ref
    }()
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func listentoRealtimeDatabase() {
        guard let databasePath = databasePath else {
            return
        }
        databasePath
            .observe(.childAdded) { [weak self] snapshot in
                guard
                    let self = self,
                    var json = snapshot.value as? [String: Any]
                else {
                    return
                }
                json["id"] = snapshot.key
                do {
                    let recipeData = try JSONSerialization.data(withJSONObject: json)
                    let recipe = try self.decoder.decode(Recipe.self, from: recipeData)
                    self.recipes.append(recipe)
                } catch {
                    print("an error occurred", error)
                }
            }
    }
    
    func stopListening() {
        databasePath?.removeAllObservers()
    }
}
