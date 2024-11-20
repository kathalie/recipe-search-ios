//
//  URLSessionRecipeProvider.swift
//  RecipeSearch
//
//  Created by Kathryn Verkhogliad on 20.11.2024.
//

import Foundation

struct URLSessionRecipeProvider: RecipeProvider {
    let rapidApiKey: String
    
    init() {
        self.rapidApiKey = ProcessInfo.processInfo.environment["RAPID_API_KEY"] ?? ""
    }
    
    func searchRecipes(by searchQuery: String) async throws -> [RecipeModel]? {
        <#code#>
    }
    
    func getRecipeInformation(by id: UUID) async throws -> RecipeInformationModel? {
        <#code#>
    }
    
    func guessNutrition(by dishName: String) async throws -> NutritionModel? {
        <#code#>
    }
    
    func classifyCuisine(by title: String, with ingredientList: String) async throws -> Cuisine? {
        <#code#>
    }
    
    
}
