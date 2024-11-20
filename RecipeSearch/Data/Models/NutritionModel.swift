//
//  CaloryModel.swift
//  RecipeSearch
//
//  Created by Kathryn Verkhogliad on 20.11.2024.
//

import Foundation

struct NutritionModel: Decodable {
    let calories: NutrientModel
    let fat: NutrientModel
    let protein: NutrientModel
    let carbs: NutrientModel
}

struct NutrientModel: Decodable {
    let value: Double
    let unit: String
}
