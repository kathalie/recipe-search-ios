//
//  Errors.swift
//  RecipeSearch
//
//  Created by Kathryn Verkhogliad on 20.11.2024.
//

import Foundation

struct RapidApiError: Error {
    let message: String
}

let errorRequestingSearchRecipe = RapidApiError(message: "Something went wrong when requesting search recipes.")
let errorRequestingRecipeInformation = RapidApiError(message: "Something went wrong when requesting recipe information.")
let errorGuessingNutrition = RapidApiError(message: "Something went wrong when guessing nutrition.")
let errorClassifyingCuisine = RapidApiError(message: "Something went wrong when classifying cuisine.")

