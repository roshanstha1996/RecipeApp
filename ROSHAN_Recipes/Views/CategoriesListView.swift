//
//  CategoriesListView.swift
//  ROSHAN_Recipes
//
//  Created by ROSHAN on 2024-11-07.
//

import SwiftUI

import SwiftUI

struct CategoriesListView: View {
    @StateObject private var categoryViewModel = CategoryViewModel()

    var body: some View {
        NavigationView {
            List(categoryViewModel.categories, id: \.idCategory) { category in
                NavigationLink(destination: RecipeListView(categoryName: category.strCategory)) {
                    HStack {
                        if let imageURL = category.strCategoryThumb {
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
                        
                        Text(category.strCategory)
                            .font(.headline)
                    }
                }
                .padding(.horizontal, 5)
            }
            .navigationTitle("Categories")
            .onAppear {
                categoryViewModel.fetchCategories()
            }
        }
    }
}


#Preview {
    CategoriesListView()
}
