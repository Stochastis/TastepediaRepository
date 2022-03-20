//
//  RecipediaApp.swift
//  Shared
//
//  Created by CSStudent on 2/14/22.
//

import SwiftUI

// Starting point for the application
// Calls the MainView() as the beginning view
@main
struct RecipediaApp: App {
    
    // Create an instance of the Pantry object to keep track of ingredients
    @StateObject var pantry = Pantry(startingIngredients: [])
    
    @StateObject var ingredientsList = IngredientsFile()
            
    // Start the application in the MainView
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(pantry).environmentObject(ingredientsList)
        }
    }
}

// The Pantry class that keeps track of all ingredients in the pantry
class Pantry: ObservableObject {
    init(startingIngredients: [String]) {
        ingredients = startingIngredients
    }
    @Published var ingredients: [String]
}

// Grabs Top 1k Ingredients list from external txt file and compiles them into an array
class IngredientsFile: ObservableObject {
    var ingredientsList: [String] = []
    
    init() {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Top1kIngredients.txt")
        
        do {
            let ingredientsText = try String(contentsOf: path)
            
            for line in ingredientsText.split(separator: "\r\n") {
                ingredientsList.append(String(line))
            }
        } catch {
            print(error.localizedDescription)
        }
        print(path.absoluteString)
        print(getDocumentDirectory())
    }
    
    func getDocumentDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

