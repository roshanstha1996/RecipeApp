//
//  FavouriteRecipe+CoreDataProperties.swift
//  ROSHAN_Recipes
//
//  Created by ROSHAN on 2024-11-07.
//
//

import Foundation
import CoreData


extension FavouriteRecipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteRecipe> {
        return NSFetchRequest<FavouriteRecipe>(entityName: "FavouriteRecipe")
    }

    @NSManaged public var idMeal: String?
    @NSManaged public var strMeal: String?
    @NSManaged public var strMealThumb: String?
    @NSManaged public var strInstructions: String?

}

extension FavouriteRecipe : Identifiable {

}
