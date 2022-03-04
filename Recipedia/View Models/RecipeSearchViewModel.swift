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
        print("Sup")
        let url: URL! = URL(string: "https://api.spoonacular.com/recipes/findByIngredients?ingredients=apples,oranges,bread&apiKey=af2da9210db04a9d8bb691d2f4166632")
        var request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if data == nil {
                    print("No data recieved.")
                }
                self.model = try! JSONDecoder().decode(RecipeSearchElement.self, from: data!)
            }
        }.resume()
        
    }
    
}
