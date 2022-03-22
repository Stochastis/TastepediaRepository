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
    @StateObject var pantry = Pantry(startingIngredients: [])
    
    // Create an instance of the IngredientsFile object to open up the txt file of ingredients and use them later
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
        if let fileURL = Bundle.main.url(forResource: "Top1kIngredients", withExtension: "txt") {
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

