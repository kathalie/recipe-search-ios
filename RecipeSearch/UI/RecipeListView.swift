//
//  TestView.swift
//  RecipeSearch
//
//  Created by Kathryn Verkhogliad on 20.11.2024.
//

import SwiftUI

class RecipeListViewModel: ObservableObject {
    @Published var recipes: [RecipeModel] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    private let recipeProvider: RecipeProvider = URLSessionRecipeProvider()
    private var offset = 0
    
    @MainActor
    func searchRecipes(searchQuery: String) async {
        offset = 0
        
        isLoading = true
        errorMessage = nil
        do {
            recipes = try await recipeProvider.searchRecipes(by: searchQuery, offset: offset)
        } catch {
            errorMessage = (error as? RapidApiError)?.message ?? "Something went wrong"
        }
        isLoading = false
    }
    
    @MainActor
    func loadMore(searchQuery: String) async {
        offset += 10
        
        isLoading = true
        errorMessage = nil
        do {
            let newRecipes = try await recipeProvider.searchRecipes(by: searchQuery, offset: offset)
            recipes.append(contentsOf: newRecipes)
        } catch {
            errorMessage = (error as? RapidApiError)?.message ?? "Something went wrong"
        }
        isLoading = false
    }
}

struct RecipeListView: View {
    @StateObject private var viewModel: RecipeListViewModel
    @State private var searchQuery = ""
    
    init() {
        _viewModel = StateObject(wrappedValue: RecipeListViewModel())
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter search query", text: $searchQuery)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading)
                        .frame(maxWidth: .infinity)
                    
                    Button("Search") {
                        Task {
                            await viewModel.searchRecipes(searchQuery: searchQuery)
                        }
                    }
                    .padding(.trailing)
                }
                .padding()
                .frame(maxWidth: .infinity)
                
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)").foregroundColor(.red)
                } else {
                    List(viewModel.recipes) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipeId: recipe.id)) {
                            RecipeView(recipe: recipe)
                        }
                    }
                    
                    if !viewModel.isLoading && viewModel.recipes.count % 10 == 0 {
                        Button("Load more") {
                            Task {
                                await viewModel.loadMore(searchQuery: searchQuery)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Recipe Search")
        }
    }
}

#Preview {
    RecipeListView()
}
