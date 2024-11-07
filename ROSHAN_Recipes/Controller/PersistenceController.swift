//
//  PersistenceController.swift
//  CoreDataDemo
//
//  Created by ROSHAN on 2024-11-07
//

import Foundation
import CoreData

struct PersistenceController{
    static let shared = PersistenceController()
    
    //instance of CoreData container
    let container : NSPersistentContainer
    
    init(inMemory : Bool = false) {
        self.container = NSPersistentContainer(name: "RecipeApp")
        
        //check if inMemory is disabled
        if inMemory{
            //use the junk file as storage which won't occupy any memory
            //data is NOT saved permanently
            self.container.persistentStoreDescriptions.first?.url = URL(filePath: "/dev/null")
        }
        
        //access CoreData persistence stores
        self.container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                print(#function, "Unable to access CoreData storage : \(error)")
            }
            
            print(#function, "Peristence store loaded : \(description)")
        }
    }
}
