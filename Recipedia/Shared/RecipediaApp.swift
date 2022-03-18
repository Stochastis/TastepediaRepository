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

    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(pantry)
        }
    }
}

class Pantry: ObservableObject {
    init(startingIngredients: [String]) {
        ingredients = startingIngredients
    }
    @Published var ingredients: [String]
}

