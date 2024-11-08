//
//  ROSHAN_RecipesApp.swift
//  ROSHAN_Recipes
//
//  Created by ROSHAN on 2024-11-07.
//

import SwiftUI

@main
struct ROSHAN_RecipesApp: App {
    //create the instance of FavouriteViewModel and set it in the Environment
    @StateObject var favouriteViewModel = FavouriteViewModel()
    
    //get the shared instance of the PersistenceController
    //and associate it to NSManagedObjectContext environment variable of the app
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(self.favouriteViewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
