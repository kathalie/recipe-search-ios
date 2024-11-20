//
//  AlamofireRecipeProvider.swift
//  RecipeSearch
//
//  Created by Kathryn Verkhogliad on 20.11.2024.
//

import Foundation
import Alamofire

struct AlamofireRecipeProvider: RecipeProvider {
    let providersConfig: ProvidersConfig = ProvidersConfig()
    
    func searchRecipes(by searchQuery: String, offset: Int) async throws -> [RecipeModel] {
        let url = providersConfig.baseUrl
            .appendingPathComponent("recipes")
            .appendingPathComponent("complexSearch")
        
        let parameters: Parameters = [
            "query": searchQuery,
            "offset": offset
        ]
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            providersConfig.apiHeader: providersConfig.rapidApiKey
        ]
        
        do {
            let result = AF.request(
                url,
                method: .get,
                parameters: parameters,
                headers: headers
            ).serializingDecodable(RecipeResultModel.self)
            
            print(await result.response)
            
            let recipeResult = try await result.value
            
            return recipeResult.results
        } catch {
            print("Error in Alamofire request: \(error.localizedDescription)")
            throw errorRequestingSearchRecipe
        }
    }
    
    func getRecipeInformation(by id: Int) async throws -> RecipeInformationModel {
        let url = providersConfig.baseUrl
            .appending(path: "recipes")
            .appending(path: "\(id)")
            .appending(path: "information")
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            providersConfig.apiHeader: providersConfig.rapidApiKey
        ]

        do {
            let result = AF.request(
                url,
                method: .get,
                headers: headers
            ).serializingDecodable(RecipeInformationModel.self)
            
            print(await result.response)
            
            return try await result.value
        } catch {
            print("Error in Alamofire request: \(error.localizedDescription)")
            throw errorRequestingRecipeInformation
        }
    }
    
    func guessNutrition(by dishName: String) async throws -> NutritionModel {
        let url = providersConfig.baseUrl
            .appending(path: "recipes")
            .appending(path: "guessNutrition")
        
        let parameters: Parameters = [
            "title": dishName
        ]
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            providersConfig.apiHeader: providersConfig.rapidApiKey
        ]

        do {
            let result = AF.request(
                url,
                method: .get,
                parameters: parameters,
                headers: headers
            ).serializingDecodable(NutritionModel.self)
            
            print(await result.response)
            
            return try await result.value
        } catch {
            print("Error in Alamofire request: \(error.localizedDescription)")
            throw errorGuessingNutrition
        }
    }
    
    func classifyCuisine(by classifyCuisineInfo: ClassifyCuisineInfo) async throws -> Cuisine {
        let url = providersConfig.baseUrl
            .appending(path: "recipes")
            .appending(path: "cuisine")
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            providersConfig.apiHeader: providersConfig.rapidApiKey
        ]

        do {
            let result = AF.request(
                url,
                method: .post,
//                parameters: classifyCuisineInfo,
                encoding: JSONEncoding.default,
                headers: headers
            ).serializingDecodable(Cuisine.self)
            
            return try await result.value
        } catch {
            print("Error in Alamofire request: \(error.localizedDescription)")
            throw errorClassifyingCuisine
        }
    }
}
