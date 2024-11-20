//
//  RecipeDetailsView.swift
//  RecipeSearch
//
//  Created by Kathryn Verkhogliad on 20.11.2024.
//

import SwiftUI

class RecipeDetailViewModel: ObservableObject {
    @Published var recipeInfo: RecipeInformationModel?
    @Published var nutritionInfo: NutritionModel?
    @Published var cuisineInfo: Cuisine?
    @Published var showErrorAlert = false
    @Published var error = ""
    
    private let recipeProvider: RecipeProvider = URLSessionRecipeProvider()
    let recipeId: Int
    
    init(recipeId: Int) {
        self.recipeId = recipeId
    }
    
    @MainActor
    func fetchRecipeDetails() async {
        do {
            recipeInfo = try await recipeProvider.getRecipeInformation(by: recipeId)
            
            let ingredientList = recipeInfo?.extendedIngredients.map { $0.name }.joined(separator: "\n") ?? ""
            let classifier = ClassifyCuisineInfo(ingredientList: ingredientList, title: recipeInfo?.title ?? "")
            cuisineInfo = try await recipeProvider.classifyCuisine(by: classifier)
        } catch {
            self.error = (error as? RapidApiError)?.message ?? "Something went wrong"
            print("Error fetching recipe details: \(error.localizedDescription)")
            
            showErrorAlert = true
        }
    }
    
    @MainActor
    func fetchNutritionInfo() async {
        guard let recipeInfo = recipeInfo else { return }
        
        do {
            nutritionInfo = try await recipeProvider.guessNutrition(by: recipeInfo.title)
        } catch {
            self.error = (error as? RapidApiError)?.message ?? "Something went wrong"
            print("Error fetching nutrition info: \(error.localizedDescription)")
            
            showErrorAlert = true
        }
    }
}

struct RecipeDetailView: View {
    @StateObject private var viewModel: RecipeDetailViewModel
    
    init(recipeId: Int) {
        _viewModel = StateObject(wrappedValue: RecipeDetailViewModel(recipeId: recipeId))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let recipeInfo = viewModel.recipeInfo {
                    Text(recipeInfo.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    HStack {
                        Text("Ready in \(recipeInfo.readyInMinutes) minutes")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Text("Servings: \(recipeInfo.servings)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom)
                    
                    Text("Summary")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    Text(recipeInfo.summary)
                        .font(.body)
                        .padding(.bottom)
                    
                    Button(action: {
                        Task {
                            await viewModel.fetchNutritionInfo()
                        }
                    }) {
                        Text("Guess Nutrition")
                    }
                    .padding(.bottom)
                    
                    if let nutritionInfo = viewModel.nutritionInfo {
                        Text("Guessed Nutrition")
                            .font(.headline)
                            .padding(.bottom, 5)
                        
                        NutritionView(nutrition: nutritionInfo)
                            .padding(.bottom)
                    }
                    
                    if let cuisineInfo = viewModel.cuisineInfo {
                        Text("Classified Cuisines")
                            .font(.headline)
                            .padding(.bottom, 5)
                        
                        List(cuisineInfo.cuisines, id: \.self) { cuisine in
                            Text(cuisine)
                                .font(.body)
                        }
                        .frame(height: 200)
                        .listStyle(PlainListStyle())
                        .padding(.bottom)
                    }
                } else {
                    ProgressView("Loading...")
                }
            }
            .padding()
        }
        .onAppear {
            Task {
                await viewModel.fetchRecipeDetails()
            }
        }
        .navigationTitle("Recipe Details")
        .alert(isPresented: $viewModel.showErrorAlert) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.error),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
