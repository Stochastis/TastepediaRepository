//
//  RecipeSearchViewModel.swift
//  Recipedia (iOS)
//
//  Created by Caleb Ross on 3/3/22.
//
// This is a View Model that mediates interactions between the view and the model that directly interacts with the API

import Foundation

class RecipeSearchViewModel: ObservableObject {
    
    var model = [RecipeSearchElement]()
    
    func findRecipes() {
        print("Sup")
        let url: URL! = URL(string: "https://api.spoonacular.com/recipes/findByIngredients?ingredients=corn,driedtomatoes,cucumber&apiKey=af2da9210db04a9d8bb691d2f4166632")
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if data == nil {
                    print("No data recieved.")
                }
                self.model = try! JSONDecoder().decode([RecipeSearchElement].self, from: data!)
            }
        }.resume()
        
    }
    
}
