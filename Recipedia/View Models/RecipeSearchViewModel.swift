//
//  RecipeSearchViewModel.swift
//  Recipedia (iOS)
//
//  Created by Caleb Ross on 3/3/22.
//

import Foundation

class RecipeSearchViewModel: ObservableObject {
    
    var model = RecipeSearchElement()
    
    func findRecipes() {
        let url: URL! = URL(string: "https://api.spoonacular.com/recipes/findByIngredients?ingredients=apples,oranges,bread&apiKey=af2da9210db04a9d8bb691d2f4166632")
        var request = URLRequest(url: url)
        
    }
    
}
