//
//  TestView.swift
//  RecipeSearch
//
//  Created by Kathryn Verkhogliad on 20.11.2024.
//

import SwiftUI

class RecipeListViewModel: ObservableObject {
    @Published var searchQuery = ""
    @Published var recipes = [RecipeModel]()
    @Published var errorMessage: String? = nil
    @Published var isLoading = false
    
    private let recipeProvider: RecipeProvider
    
    init(recipeProvider: RecipeProvider = URLSessionRecipeProvider()) {
        self.recipeProvider = recipeProvider
    }
    
    @MainActor
    func performSearch() async {
        guard !searchQuery.isEmpty else { return }
        
        isLoading = true
        errorMessage = nil
        do {
//            recipes = try await recipeProvider.searchRecipes(by: searchQuery)
//            print(recipes)
            
            let recipe = try await recipeProvider.getRecipeInformation(by: 658579)
//            print(recipe)
            
//            let result = try await recipeProvider.guessNutrition(by: searchQuery)
//            print(result)
            
            let ingredientList = recipe.extendedIngredients.map{$0.name}.joined(separator: "\n")
            
            let classifier = ClassifyCuisineInfo(ingredientList: ingredientList, title: recipe.title)
            let result = try await recipeProvider.classifyCuisine(by: classifier)
            print(result)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}

struct RecipeListView: View {
    @StateObject private var viewModel = RecipeListViewModel()

    var body: some View {
        VStack {
            TextField("Enter search query", text: $viewModel.searchQuery)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Search") {
                Task {
                    await viewModel.performSearch()
                }
            }
            .padding()

//            if viewModel.isLoading {
//                ProgressView("Loading...")
//            } else if let errorMessage = viewModel.errorMessage {
//                Text("Error: \(errorMessage)")
//                    .foregroundColor(.red)
//            } else {
//                List(viewModel.recipes) { recipe in
//                    VStack(alignment: .leading) {
//                        Text(recipe.title)
//                            .font(.headline)
//                        if let description = recipe.description {
//                            Text(description)
//                                .font(.subheadline)
//                        }
//                    }
//                }
//            }
        }
        .padding()
    }
}

#Preview {
    RecipeListView()
}
