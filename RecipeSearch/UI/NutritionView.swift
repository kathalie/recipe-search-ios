//
//  NutritionView.swift
//  RecipeSearch
//
//  Created by Kathryn Verkhogliad on 20.11.2024.
//

import SwiftUI

struct NutritionView: View {
    let nutrition: NutritionModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Nutrition Information")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
            
            Group {
                NutrientSection(title: "Calories", nutrient: nutrition.calories)
                NutrientSection(title: "Fat", nutrient: nutrition.fat)
                NutrientSection(title: "Protein", nutrient: nutrition.protein)
                NutrientSection(title: "Carbs", nutrient: nutrition.carbs)
            }
            .padding(.horizontal)
        }
        .padding(.bottom)
    }
}
