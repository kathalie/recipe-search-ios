//
//  Cuisine.swift
//  RecipeSearch
//
//  Created by Kathryn Verkhogliad on 20.11.2024.
//

import Foundation

struct Cuisine: Decodable {
    let cuisines: [String]
}

struct ClassifyCuisineInfo: Encodable {
    let ingredientList: String
    let title: String
}
