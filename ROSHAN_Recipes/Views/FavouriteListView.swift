//
//  RecipeDetailView.swift
//  ROSHAN_Recipes
//
//  Created by ROSHAN on 2024-11-07.
//

import SwiftUI
import CoreData

struct FavouriteListView: View {
    @EnvironmentObject var favouriteViewModel: FavouriteViewModel

    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    
    @State private var selectedFavourite: FavouriteRecipe?

    var body: some View {
        NavigationStack {
            List {
                ForEach(self.favouriteViewModel.favourites) { favourite in
                    // Removed the NavigationLink to disable navigation
                    HStack {
                        if let imageURLString = favourite.strMealThumb,
                           let imageURL = URL(string: imageURLString) {
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
                        } else {
                            // Placeholder image if no URL is available
                            Image("empty_image")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 64, height: 64)
                        }

                        VStack(alignment: .leading) {
                            Text(favourite.strMeal ?? "NA")
                                .font(.headline)
                        }
                    } // End of HStack
                } // End of ForEach
                .onDelete { indexSet in
                    if let index = indexSet.first {
                        let favourite = self.favouriteViewModel.favourites[index]
                        self.selectedFavourite = favourite
                        self.alertTitle = "Confirm Deletion"
                        self.alertMessage = "Are you sure you want to remove this recipe from your favorites?"
                        self.showAlert = true
                    }
                } // End of onDelete
            } // End of List
            .navigationTitle("Favourites")
            .alert(isPresented: self.$showAlert) {
                Alert(
                    title: Text(self.alertTitle),
                    message: Text(self.alertMessage),
                    primaryButton: .default(Text("Delete")) {
                        
                        if let favourite = selectedFavourite {
                            if favouriteViewModel.removeFavouriteById(idMeal: favourite.idMeal ?? "") {
                                self.alertTitle = ""
                                self.alertMessage = "Successfully removed from Favorites."
                                favouriteViewModel.fetchFavourites() // Refresh the list
                            } else {
                                self.alertTitle = "Failure"
                                self.alertMessage = "Unable to remove from Favorites."
                            }
                        }
                    },
                    secondaryButton: .cancel()// on cancel do nothing
                )
            }
        }
        .onAppear {
            self.favouriteViewModel.fetchFavourites()
        }
    }
}

#Preview {
    FavouriteListView()
}
