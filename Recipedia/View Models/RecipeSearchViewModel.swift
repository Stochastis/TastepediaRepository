//
//  RecipeSearchViewModel.swift
//  Recipedia (iOS)
//
//  Created by Caleb Ross on 3/3/22.
//
// This is a View Model that mediates interactions between the view and the model that directly interacts with the API

import Foundation

class RecipeSearchViewModel: ObservableObject {
    
    @Published var model = [RecipeSearchElement]()
    
    func findRecipes(inputs: [String]) {
        
        // Create custom URL with desired ingredients from inputs parameter
        var ingredientString = ""
        for ingredient in inputs {
            ingredientString += ingredient + ","
        }
        ingredientString = String(ingredientString.dropLast())
        let url: URL! = URL(string: "https://api.spoonacular.com/recipes/findByIngredients?ingredients=" + ingredientString + "&ranking=2&apiKey=af2da9210db04a9d8bb691d2f4166632")
        print(url.absoluteString)
        
        let request = URLRequest(url: url)
        
        // Make the API call
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if data == nil {
                    print("No data recieved.")
                }
                self.model = try! JSONDecoder().decode([RecipeSearchElement].self, from: data!)
                if self.model.isEmpty {
                    print("model is empty.")
                    self.model.append(RecipeSearchElement(title: "No Recipes Found"))
                }
                print(String(self.model[0].title!))
            }
        }
        session.resume()
    }
}

