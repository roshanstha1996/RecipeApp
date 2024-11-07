//
//  RecipeViewModel.swift
//  ROSHAN_Recipes
//
//  Created by Aswin Dahal on 2024-11-07.
//

import Foundation
import Alamofire

class RecipeViewModel: ObservableObject {
    
    @Published var recipes: [Recipe] = []
    @Published var selectedRecipe : Recipe?
    
    //fetch all products
    func fetchRecipeListByCategory(categoryName: String) {
        let apiURL = "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(categoryName)"
        
        AF.request(apiURL)
            .response { resp in
                switch resp.result {
                    case .success(let apiResponse):
                        do {
                            let jsonData = try JSONDecoder().decode(RecipeListResponse.self, from: apiResponse!)
                            
                            self.recipes = jsonData.meals
                        } catch {
                            print("Decoding error: \(error.localizedDescription)")
                        }
                    case .failure(let error):
                        print("Failed Recipe List Response \(error)")
                }
            }
    }
    
    func fetchRecipeById(id: String) {
        let apiURL = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
        
        AF.request(apiURL)
            .response { resp in
                switch resp.result {
                case .success(let apiResponse):
                    do {
                        let jsonData = try JSONDecoder().decode(RecipeLookupResponse.self, from: apiResponse!)
                        self.selectedRecipe = jsonData.meals.first
                        
                        print(jsonData)
                    } catch {
                        print("Decoding error: \(error.localizedDescription)")
                    }
                case .failure(let error):
                    print("Failed Recipe Response \(error)")
                }
            }
    }
}
