//
//  RecipeListView.swift
//  ROSHAN_Recipes
//
//  Created by ROSHAN on 2024-11-07.
//

import SwiftUI

struct RecipeListView: View {
    let categoryName: String
    @StateObject private var recipeViewModel = RecipeViewModel()

    var body: some View {
        List(recipeViewModel.recipes, id: \.idMeal) { recipe in
            NavigationLink(destination: RecipeDetailView(recipeID: recipe.idMeal)) {
                HStack {
                    
                    if let imageURL = recipe.strMealThumb {
                        AsyncImage(url: imageURL) { phase in
                            switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 64, height: 64)
                                default:
                                    Image("empty_image")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 64, height: 64)
                            }
                        }
                    } // If Ending
                    
                    Text(recipe.strMeal)
                        .font(.headline)
                        .padding(.leading)
                }
                .padding()
            }
        }
        .navigationTitle(categoryName)
        .onAppear {
            recipeViewModel.fetchRecipeListByCategory(categoryName: categoryName)
        }
    }
}



//#Preview {
//    RecipeListView()
//}
