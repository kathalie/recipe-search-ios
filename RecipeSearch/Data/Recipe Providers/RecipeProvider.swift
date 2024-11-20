//
//  RecipeProvider.swift
//  RecipeSearch
//
//  Created by Kathryn Verkhogliad on 20.11.2024.
//

import Foundation

protocol RecipeProvider {
    func searchRecipes(by searchQuery: String) async throws -> [RecipeModel]
    func getRecipeInformation(by id: Int) async throws -> RecipeInformationModel
    func guessNutrition(by dishName: String) async throws -> NutritionModel
    func classifyCuisine(by classifyCuisineInfo: ClassifyCuisineInfo) async throws -> Cuisine
}
