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
//        print("\(#fileID): Line \(#line):")
//        print("Running findRecipes().....")
        
        // Create custom URL with desired ingredients from inputs parameter
        var ingredientString = ""
        for ingredient in inputs {
            ingredientString += ingredient + ","
        }
        ingredientString = String(ingredientString.dropLast())
//        print("\(#fileID): Line \(#line):")
//        print("Ingredients: " + ingredientString)
        let url: URL! = URL(string: "https://api.spoonacular.com/recipes/findByIngredients?ingredients=" + ingredientString + "&apiKey=af2da9210db04a9d8bb691d2f4166632")
//        print("\(#fileID): Line \(#line):")
//        print("URL: " + url.absoluteString)
        
        let request = URLRequest(url: url)
        
        // Make the API call
//        print("\(#fileID): Line \(#line):")
//        print("Outide URLSession.shared.dataTask.....")
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
//            print("\(#fileID): Line \(#line):")
//            print("Inside URLSession.shared.dataTask.....")
            DispatchQueue.main.async {
//                print("\(#fileID): Line \(#line):")
//                print("Inside DispatchQueue.main.async....")
                if data == nil {
//                    print("\(#fileID): Line \(#line):")
                    print("No data recieved.")
                }
//                print("\(#fileID): Line \(#line):")
//                print("data != nil.... Moving on to JSONDecoder....")
                self.model = try! JSONDecoder().decode([RecipeSearchElement].self, from: data!)
                print(self.model[0].title)
            }
        }
        session.resume()
        
//        print("\(#fileID): Line \(#line):")
//        print("Outside URLSession.shared.dataTask.....")
//        print(model)
        
    }
    
}
