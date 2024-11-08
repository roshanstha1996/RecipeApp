//
//  FavouriteViewModel.swift
//  ROSHAN_Recipes
//
//  Created by Aswin Dahal on 2024-11-07.
//

import Foundation
import CoreData

class FavouriteViewModel : ObservableObject{
    
    let context = PersistenceController.shared.container.viewContext
    @Published var favourites : [FavouriteRecipe] = []
    
    init(){
        self.fetchFavourites()
    }
    
    func addToFavourite(idMeal: String, strMeal: String, strMealThumb : URL, strInstructions : String) -> Bool{
        
        if favourites.contains(where: { $0.idMeal == idMeal }) {
            print("Recipe is already in favorites")
            return false // Return false if recipe is already a favorite
        }
        //get a new reference to Book entity
        let newFavourite = NSEntityDescription.insertNewObject(forEntityName: "FavouriteRecipe", into: self.context) as! FavouriteRecipe
        
        //set the reference with required properties
        newFavourite.idMeal = idMeal
        newFavourite.strMeal = strMeal
        newFavourite.strMealThumb = strMealThumb.absoluteString
        newFavourite.strInstructions = strInstructions
        
        //save the new object to store and return the response
        return saveContext()
    }
    
    func fetchFavourites(){
        //FetchRequest
        
        //get instance of Fetch Request
        let request : NSFetchRequest<FavouriteRecipe> = FavouriteRecipe.fetchRequest()
        
        //sort records using SortDescritor
        
        //sort by descending order of title
        let titleSort = NSSortDescriptor.init(key: "strMeal", ascending: false)
        request.sortDescriptors = [titleSort]
        
        do{
            //execute the FetchRequest
            self.favourites = try self.context.fetch(request)
            print(#function, "Data fetched from database : \(self.favourites)")
        }catch{
            print(#function, "Can't retrieve from database : \(error)")
        }
    }
    
    
//    func removeFavourite(recipeToDelete : FavouriteRecipe) -> Bool{
//        //try to delete the object from the Persistence store
//        
//        self.context.delete(recipeToDelete)
//        return self.saveContext()
//        
//    }
    
    func removeFavouriteById(idMeal: String) -> Bool {
            let fetchRequest: NSFetchRequest<FavouriteRecipe> = FavouriteRecipe.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "idMeal == %@", idMeal)
            
            do {
                let favouritesToDelete = try context.fetch(fetchRequest)
                if let favouriteToDelete = favouritesToDelete.first {
                    context.delete(favouriteToDelete)
                    return saveContext()
                }
            } catch {
                print(#function, "Failed to delete favorite by id: \(error)")
            }
            return false
        }
    
    
    private func saveContext() -> Bool{
        do{
            if (self.context.hasChanges){
                try self.context.save()
                
                //refresh the list of books
                self.fetchFavourites()
                return true
            }
        }catch{
            print(#function, "Unable to perform operation : \(error)")
            return false
        }
        
        return false
    }
}
