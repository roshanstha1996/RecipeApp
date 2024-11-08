//
//  RecipeDetailView.swift
//  ROSHAN_Recipes
//
//  Created by ROSHAN on 2024-11-07.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipeID: String
    @StateObject private var viewModel = RecipeViewModel()
    @StateObject private var favouriteViewModel = FavouriteViewModel()
    @State private var isFavorite = false
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var alertTitle = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let recipe = viewModel.selectedRecipe {
                    HStack(spacing: 16) {
                        // Image on the left
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
                                            .frame(width: 128, height: 128)
                                }
                            }
                        }
                        
                        // Recipe title on the right
                        VStack(alignment: .leading, spacing: 8) {
                            Text(recipe.strMeal)
                                .font(.title)
                                .fontWeight(.bold)
                        }
                    }
                    
                    
                    // Favorite button below the content
                    Button(action: {
                        isFavorite.toggle()
                        
                        if isFavorite {
                            if let strMealThumb = recipe.strMealThumb {
                                if (favouriteViewModel.addToFavourite(
                                    idMeal: recipe.idMeal,
                                    strMeal: recipe.strMeal,
                                    strMealThumb: strMealThumb,
                                    strInstructions: recipe.strInstructions ?? ""
                                )) {
                                    alertMessage = "Recipe added to favorites."
                                } else {
                                    alertMessage = "This recipe is already in your favorites."
                                    isFavorite = false
                                    showAlert = true
                                }
                            } else {
                                print("strMealThumb is nil, cannot add to favorites")
                            }
                        } else {
                            // Code to remove from favorites
                            if self.favouriteViewModel.removeFavouriteById(idMeal: recipe.idMeal ?? "") {
                                self.alertTitle = ""
                                self.alertMessage = "Successfully removed from Favorites"
                            } else {
                                self.alertTitle = "Failure"
                                self.alertMessage = "Can't remove from Favorites"
                            }

                            self.showAlert = true
                        }
                        
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
                    
                    // Instructions section
                    Text("Instructions")
                        .font(.title2)
                    Text(recipe.strInstructions ?? "No instructions available")
                        .padding(.bottom)
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
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(self.alertTitle),
                message: Text(alertMessage),
                dismissButton: .default(Text("Okay"))
            )
        }
    }
}

#Preview {
    RecipeDetailView(recipeID: "exampleID") // Add an example ID for the preview
}

