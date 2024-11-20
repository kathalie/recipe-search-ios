//
//  RecipeThumbnailView.swift
//  RecipeSearch
//
//  Created by Kathryn Verkhogliad on 20.11.2024.
//

import SwiftUI

struct RecipeView: View {
    let recipe: RecipeModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            AsyncImage(url: URL(string: recipe.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(width: 200, height: 200)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .cornerRadius(10)
                        .clipped()
                case .failure:
                    Text("Failed to load")
                @unknown default:
                    Text("Failed to load")
                }
            }
            
            Text(recipe.title)
                .font(.headline)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding([.top, .horizontal])
        }
        .padding()
        .cornerRadius(15)
        .frame(maxWidth: .infinity)
        .padding([.horizontal, .top])
    }
}
