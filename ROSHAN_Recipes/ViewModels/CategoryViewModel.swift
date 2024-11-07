//
//  CategoryViewModel.swift
//  ROSHAN_Recipes
//
//  Created by ROSHAN on 2024-11-07.
//

import Foundation
import Alamofire

class CategoryViewModel: ObservableObject {
    @Published var categories: [Category] = []
    
    //fetch all products
    func fetchCategories() {
        let apiURL = "https://www.themealdb.com/api/json/v1/1/categories.php"
        
        AF.request(apiURL)
            .response { resp in
                switch resp.result {
                    case .success(let apiResponse):
                        do {
                            let jsonData = try JSONDecoder().decode(CategoryResponse.self, from: apiResponse!)
                            // mapping the categories into the category list
                            self.categories = jsonData.categories
                            
                        } catch {
                            print(error.localizedDescription)
                        }
                    case .failure(let error):
                        print(#function, "Failed Category Response \(error)")
                }
            }
    }
}
