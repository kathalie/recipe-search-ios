//
//  NutrientSection.swift
//  RecipeSearch
//
//  Created by Kathryn Verkhogliad on 20.11.2024.
//

import SwiftUI

struct NutrientSection: View {
    let title: String
    let nutrient: NutrientModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
            
            HStack {
                Text("Value: \(nutrient.value, specifier: "%.2f") \(nutrient.unit)")
                    .font(.body)
                Spacer()
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10)
        )
    }
}
