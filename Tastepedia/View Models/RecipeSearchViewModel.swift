//
//  RecipeSearchViewModel.swift
//  Tastepedia (iOS)
//
//  Created by Caleb Ross on 3/3/22.
//
// This is a View Model that mediates interactions between the view and the model that directly interacts with the API

import Foundation

class RecipeSearchViewModel: ObservableObject {
    
    @Published var foundRecipes = [RecipeSearchElement]() // Stores the recipes found by the API call
    
    // Creates a URL from a string containing all the ingredients stored in the Pantry and uses that URL to make an API call to Spoonacular
    func findRecipes(ingredients: [String]) {
        
        // Create custom URL with desired ingredients from inputs parameter
        var ingredientString = ""
        for ingredient in ingredients {
            ingredientString += ingredient.replacingOccurrences(of: " ", with: "") + ","
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
                do {
                    self.foundRecipes = try JSONDecoder().decode([RecipeSearchElement].self, from: data!)
                    print("Successfully decoded JSON")
                } catch {
                    print("Trouble decoding JSON. Error below.")
                    print("Error: \(error)")
                }
                if self.foundRecipes.isEmpty {
                    print("Model is empty.")
                    self.foundRecipes.append(RecipeSearchElement(title: "No Recipes Found"))
                }
            }
        }
        session.resume()
    }
}

