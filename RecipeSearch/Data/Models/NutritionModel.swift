//
//  CaloryModel.swift
//  RecipeSearch
//
//  Created by Kathryn Verkhogliad on 20.11.2024.
//

import Foundation

struct NutritionModel: Decodable {
    let recipesUsed: Int
    let calories: NutrientModel
    let fat: NutrientModel
    let protein: NutrientModel
    let carbs: NutrientModel
}

struct NutrientModel: Decodable {
    let value: Double
    let unit: String
    let confidenceRange95Percent: ConfidenceRangeModel
    let standardDeviation: Double
}

struct ConfidenceRangeModel: Decodable {
    let min: Double
    let max: Double
}
