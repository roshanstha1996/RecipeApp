//
//  CategoryResponse.swift
//  ROSHAN_Recipes
//
//  Created by Aswin Dahal on 2024-11-07.
//

import Foundation

struct CategoryResponse: Decodable {
    let categories: [Category]
}

struct Category: Decodable {
//    let idCategory: Int
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: URL?
    let strCategoryDescription: String
}

