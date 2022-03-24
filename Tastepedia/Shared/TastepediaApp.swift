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

// The Pantry class that verifies the existence of 'savedIngredients' in UserDefaults and stores ingredients in local storage
class Pantry: ObservableObject {
    init() {
        if UserDefaults.standard.object(forKey: "savedIngredients") == nil {
            UserDefaults.standard.setValue([], forKey: "savedIngredients")
        }
        ingredients = UserDefaults.standard.object(forKey: "savedIngredients") as? [String] ?? [String]()
    }
    @Published var ingredients: [String]
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

