//
//  Recipe.swift
//  RecipeBrowser
//
//  Created by Jinho An on 04.05.24.
//

import Foundation

struct Recipe: Identifiable, Decodable {
    var id: String
    var recipeName: String
    var author: String
    var ingredients: String
    var directions: String
    var photoURLs: String
}
