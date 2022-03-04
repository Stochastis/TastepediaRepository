//
//  RecipeSearch.swift
//  Recipedia (iOS)
//
//  Created by Caleb Ross on 3/3/22.
//

import Foundation

// MARK: - RecipeSearch
struct RecipeSearch: Codable {
    let id: Int?
    let title: String?
    let image: String?
    let imageType: ImageType?
    let usedIngredientCount, missedIngredientCount: Int?
    let missedIngredients, usedIngredients, unusedIngredients: [SedIngredient]?
    let likes: Int?
}

enum ImageType: String, Codable {
    case jpg = "jpg"
}

// MARK: - SedIngredient
struct SedIngredient: Codable {
    let id: Int?
    let amount: Double?
    let unit, unitLong, unitShort, aisle: String?
    let name, original, originalName: String?
    let meta: [String]?
    let image: String?
    let extendedName: String?
}
