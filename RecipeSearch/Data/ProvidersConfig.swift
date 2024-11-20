//
//  Config.swift
//  RecipeSearch
//
//  Created by Kathryn Verkhogliad on 20.11.2024.
//

import Foundation

struct ProvidersConfig {
    let baseUrl: URL = URL(string: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com")!
    let apiHeader = "x-rapidapi-key"
    let rapidApiKey: String
    
    init() {
        self.rapidApiKey = ProcessInfo.processInfo.environment["RAPID_API_KEY"] ?? ""
    }
}
