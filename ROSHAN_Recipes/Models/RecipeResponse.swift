//
//  RecipeResponse.swift
//  ROSHAN_Recipes
//
//  Created by ROSHAN on 2024-11-07.
//

import Foundation

//response structure for recipe list by category
struct RecipeListResponse: Decodable {
    let meals: [Recipe]
}

//response structire for recipe by id
struct RecipeLookupResponse: Decodable {
    let meals: [Recipe]
}

struct Recipe: Decodable {
//    let idMeal: Int
    let idMeal: String
    let strMeal: String
    let strMealThumb: URL?
    let strInstructions: String?
}
