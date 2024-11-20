//
//  URLSessionRecipeProvider.swift
//  RecipeSearch
//
//  Created by Kathryn Verkhogliad on 20.11.2024.
//

import Foundation

struct URLSessionRecipeProvider: RecipeProvider {
    let providersConfig: ProvidersConfig = ProvidersConfig()
    
    func searchRecipes(by searchQuery: String) async throws -> [RecipeModel] {
        let url = providersConfig.baseUrl
            .appending(path: "recipes")
            .appending(path: "complexSearch")
            .appending(queryItems: [URLQueryItem(name: "query", value: searchQuery)])
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(providersConfig.rapidApiKey, forHTTPHeaderField: providersConfig.apiHeader)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard
            let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode)
        else {
            print("Search recipes failed for query=\(searchQuery): \(response)")
            
            throw errorRequestingSearchRecipe
        }
        
        do {
            print(String(data: data, encoding: .utf8) ?? "")
            let decodedData = try JSONDecoder().decode(RecipeResultModel.self, from: data)
            
            return decodedData.results
        } catch {
            print("Decoding Error: \(error).")
            
            throw errorRequestingSearchRecipe
        }
    }
    
    func getRecipeInformation(by id: Int) async throws -> RecipeInformationModel {
        let url = providersConfig.baseUrl
            .appending(path: "recipes")
            .appending(path: "\(id)")
            .appending(path: "information")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(providersConfig.rapidApiKey, forHTTPHeaderField: providersConfig.apiHeader)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard
            let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode)
        else {
            print("Getting recipe information for id=\(id) failed: \(response)")
            
            throw errorRequestingRecipeInformation
        }
        
        do {
            print(String(data: data, encoding: .utf8) ?? "")
            let decodedData = try JSONDecoder().decode(RecipeInformationModel.self, from: data)
            
            return decodedData
        } catch {
            print("Decoding Error: \(error).")
            
            throw errorRequestingRecipeInformation
        }
    }
    
    func guessNutrition(by dishName: String) async throws -> NutritionModel {
        let url = providersConfig.baseUrl
            .appending(path: "recipes")
            .appending(path: "guessNutrition")
            .appending(queryItems: [URLQueryItem(name: "title", value: dishName)])
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(providersConfig.rapidApiKey, forHTTPHeaderField: providersConfig.apiHeader)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard
            let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode)
        else {
            print("Guessing nutrition for title=\(dishName) failed: \(response)")
            
            throw errorGuessingNutrition
        }
        
        do {
            print(String(data: data, encoding: .utf8) ?? "")
            let decodedData = try JSONDecoder().decode(NutritionModel.self, from: data)
            
            return decodedData
        } catch {
            print("Decoding Error: \(error).")
            
            throw errorGuessingNutrition
        }
    }
    
    func classifyCuisine(by classifyCuisineInfo: ClassifyCuisineInfo) async throws -> Cuisine {
        let url = providersConfig.baseUrl
            .appending(path: "recipes")
            .appending(path: "cuisine")
        
        let jsonData = try JSONEncoder().encode(classifyCuisineInfo)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(providersConfig.rapidApiKey, forHTTPHeaderField: providersConfig.apiHeader)
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard
            let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode)
        else {
            print("Cuisine classification for \(classifyCuisineInfo) failed: \(response)")
            
            throw errorClassifyingCuisine
        }
        
        do {
            print(String(data: data, encoding: .utf8) ?? "")
            let decodedData = try JSONDecoder().decode(Cuisine.self, from: data)
            
            return decodedData
        } catch {
            print("Decoding Error: \(error).")
            
            throw errorClassifyingCuisine
        }
    }
    
    
}
