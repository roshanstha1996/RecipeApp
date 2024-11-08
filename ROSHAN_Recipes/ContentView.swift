//
//  ContentView.swift
//  ROSHAN_Recipes
//
//  Created by ROSHAN on 2024-11-07.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CategoriesListView()
                .tabItem {
                    Label("Categories", systemImage: "list.bullet")
                }

            FavouriteListView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
