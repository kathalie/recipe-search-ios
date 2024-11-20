//
//  RecipeModel.swift
//  RecipeSearch
//
//  Created by Kathryn Verkhogliad on 20.11.2024.
//

import Foundation

struct RecipeResultModel: Decodable {
    let results: [RecipeModel]
    let offset: Int
    let number: Int
    let totalResults: Int
}

struct RecipeModel: Identifiable, Decodable {
    let id: Int
    let title: String
    let image: String
    let imageType: String
}

struct RecipeInformationModel: Decodable {
    let id: Int
    let vegetarian: Bool?
    let vegan: Bool?
    let glutenFree: Bool?
    let dairyFree: Bool?
    let veryHealthy: Bool?
    let cheap: Bool?
    let veryPopular: Bool?
    let sustainable: Bool?
    let lowFodmap: Bool?
    let weightWatcherSmartPoints: Int?
    let gaps: String?
    let preparationMinutes: Int?
    let cookingMinutes: Int?
    let healthScore: Int?
    let creditsText: String?
    let license: String?
    let sourceName: String?
    let pricePerServing: Double?
    let extendedIngredients: [IngredientModel]
    let title: String
    let readyInMinutes: Int
    let servings: Int
    let image: String?
    let imageType: String?
    let summary: String
    let instructions: String
}

