//
//  IngredientModel.swift
//  RecipeSearch
//
//  Created by Kathryn Verkhogliad on 20.11.2024.
//

import Foundation

struct IngredientModel: Decodable {
    let id: Int
    let aisle: String
    let image: String
    let consistency: String
    let name: String
    let nameClean: String
    let original: String
    let originalName: String
    let amount: Double
    let unit: String
    let measures: MeasuresModel
}

struct MeasuresModel: Decodable {
    let us: MeasureModel
    let metric: MeasureModel
}

struct MeasureModel: Decodable {
    let amount: Double
    let unitShort: String
    let unitLong: String
}
