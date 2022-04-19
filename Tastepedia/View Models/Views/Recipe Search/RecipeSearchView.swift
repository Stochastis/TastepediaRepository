//
//  RecipeSearchView.swift
//  Tastepedia (iOS)
//
//  Created by Caleb Ross on 3/17/22.
//
//  This page allows users to search for recipes

import SwiftUI

struct RecipeSearchView: View {
    // Required so that this view can be 'dismissed' with a closure
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // A variable for keeping track of the phone's current color scheme
    @Environment(\.colorScheme) var colorScheme
    
    // Used to store the titles of recipes gathered from the API call
    @State var recipes: [String] = []
    
    // Create a View Model to interact with the API
    @StateObject var model = RecipeSearchViewModel()
    
    // Access the pantry environment object
    @EnvironmentObject var pantry: Pantry
        
    var body: some View {
        // Show all the recipe results
        ScrollView {
            // Grabs recipes from the Spoonacular API through the RecipeSearchViewModel
            Button(action: {
                // Find recipes given the Pantry's current ingredients.
                model.findRecipes(inputs: pantry.ingredients)
                // Clear previous recipe results
                recipes.removeAll()
                // Add current recipe results
                for index in 0..<(model.foundRecipes.count) {
                    recipes.append(model.foundRecipes[index].title ?? "Placeholder Recipe Title")
                }
            }, label: {
                Text("Tap Here To Search For Recipes")
            })
            
            // Display each recipe result in a grid
            ForEach(0 ..< model.foundRecipes.count, id: \.self) { i in
                if (oneSquare(loop: i, count: model.foundRecipes.count)) {
                    // TO-DO: Look at simplifying this view call. Maybe create another initializer for Recipe class.
                    RecipeButtonView(recipe: ObservableRecipe(model.foundRecipes[i].id!, model.foundRecipes[i].title!, IngredientsInformation(recipe: model.foundRecipes[i]), InstructionSearchElement(name: "", steps: [Step(number: 1, step: "Loading Recipe Instructions...")])))
                }
                
                else {
                    if (twoSquares(loop: i)) {
                        HStack {
                            // TO-DO: Look at simplifying this view call. Maybe create another initializer for Recipe class.
                            RecipeButtonView(recipe: ObservableRecipe(model.foundRecipes[i].id!, model.foundRecipes[i].title!, IngredientsInformation(recipe: model.foundRecipes[i]), InstructionSearchElement(name: "", steps: [Step(number: 1, step: "Loading Recipe Instructions...")])))
                            // TO-DO: Look at simplifying this view call. Maybe create another initializer for Recipe class.
                            RecipeButtonView(recipe: ObservableRecipe(model.foundRecipes[i-1].id!, model.foundRecipes[i-1].title!, IngredientsInformation(recipe: model.foundRecipes[i-1]), InstructionSearchElement(name: "", steps: [Step(number: 1, step: "Loading Recipe Instructions...")])))
                        }
                    } else {
                        EmptyView()
                    }
                }
            }
        }.navigationTitle("Recipe Search") // Title at the top of the page
    }
}
