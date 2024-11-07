//
//  RecipeDetailView.swift
//  ROSHAN_Recipes
//
//  Created by Aswin Dahal on 2024-11-07.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipeID: String
    @StateObject private var viewModel = RecipeViewModel()
    @State private var isFavorite = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let recipe = viewModel.selectedRecipe {
                    if let imageURL = recipe.strMealThumb {
                        AsyncImage(url: imageURL) { phase in
                            switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 128, height: 128)
                                default:
                                    Image("empty_image")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 64, height: 64)
                            }
                        }
                    } // If Ending
                    
                    Text(recipe.strMeal)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Instructions")
                        .font(.title)
                    Text(recipe.strInstructions ?? "No instructions available")
                        .padding(.bottom)
                    
                    // Favorite button can be added here
                    Button(action: {
                        isFavorite.toggle()
//                        viewModel.toggleFavorite(recipeID: recipeID, isFavorite: isFavorite)
                        
                        print("is favourite: \(isFavorite)")
                    }) {
                        HStack {
                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                            Text(isFavorite ? "Remove from Favorites" : "Add to Favorites")
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                } else {
                    ProgressView()
                }
            }
            .padding()
        }
        .navigationTitle("Recipe Detail")
        .onAppear {
            viewModel.fetchRecipeById(id: recipeID)
        }
    }
}


//#Preview {
//    RecipeDetailView()
//}
