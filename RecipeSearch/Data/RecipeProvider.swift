//
//  RecipeProvider.swift
//  RecipeSearch
//
//  Created by Kathryn Verkhogliad on 20.11.2024.
//

import Foundation

protocol RecipeProvider {
    func searchRecipes(by searchQuery: String) async throws -> [RecipeModel]?
    func getRecipeInformation(by id: UUID) async throws -> RecipeInformationModel?
    func guessNutrition(by dishName: String) async throws -> NutritionModel?
    func classifyCuisine(by title: String, with ingredientList: String) async throws -> Cuisine?
}
