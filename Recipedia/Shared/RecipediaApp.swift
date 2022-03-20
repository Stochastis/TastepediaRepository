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
    @StateObject var pantry = Pantry(startingIngredients: ["Salt", "Garlic", "Peppers", "Avacado", "Beef"])
            
    // Start the application in the MainView
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(pantry)
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

