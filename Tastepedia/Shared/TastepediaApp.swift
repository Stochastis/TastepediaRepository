//
//  Tastepedia.swift
//  Shared
//
//  Created by CSStudent on 2/14/22.
//

import SwiftUI

// Starting point for the application
// Calls the MainView() as the beginning view
@main
struct Tastepedia: App {
    
    // Create an instance of the Pantry object to keep track of ingredients
    @StateObject var pantry = Pantry()
    
    // Create an instance of the IngredientsFile object to open up the txt file of ingredients and use them later
    @StateObject var ingredientsList = IngredientsFile()
    
    // Start the application in the MainView
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(pantry).environmentObject(ingredientsList)
        }
    }
}

// The Pantry class that verifies the existence of 'savedIngredients' in UserDefaults
// Also has the ability to add/remove ingredients to/from local storage
class Pantry: ObservableObject {
    @Published var ingredients: [String]

    init() {
        if UserDefaults.standard.object(forKey: "savedIngredients") == nil {
            UserDefaults.standard.setValue([], forKey: "savedIngredients")
        }
        ingredients = UserDefaults.standard.object(forKey: "savedIngredients") as? [String] ?? [String]()
    }
    
    func addIngredient(_ ingredientToAdd: String){
        ingredients.append(ingredientToAdd)
        UserDefaults.standard.set(ingredients, forKey: "savedIngredients")
    }
    
    func removeIngredient(_ ingredientToRemove: String){
        ingredients.remove(at: ingredients.firstIndex(where: {$0 == ingredientToRemove}) ?? 0)
        UserDefaults.standard.set(ingredients, forKey: "savedIngredients")
    }
}

// Grabs Master Ingredients List from external txt file and compiles them into an array
class IngredientsFile: ObservableObject {
    var ingredientsList: [String] = []
    
    init() {
        if let fileURL = Bundle.main.url(forResource: "MasterIngredientsList", withExtension: "txt") {
            if let fileContents = try? String(contentsOf: fileURL) {
                print("Loaded ingredients file from bundle.")
                for line in fileContents.split(separator: "\r\n") {
                    ingredientsList.append(String(line))
                }
            } else {
                print("Error loading ingredients file.")
            }
        }
    }
    
    func getDocumentDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

// Checks if there needs to be one big square for an odd number of ingredients in the pantry
// Using this function to minimize indexing time instead of doing this all in-line
func oneSquare(loop: Int, count: Int) -> Bool {
    let first: Bool = ((count - loop) == 1);
    let second: Bool = ((count % 2) == 1);
    let final: Bool = (first && second);
    return final;
}

// Checks if there needs to be two smaller squares for an even number of ingredients in the pantry
// Using this function to minimize indexing time instead of doing this all in-line
func twoSquares(loop: Int) -> Bool {
    return (loop % 2 == 1)
}
