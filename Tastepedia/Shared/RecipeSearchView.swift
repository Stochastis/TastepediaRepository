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
                    NavigationLink(destination: RecipeDetailsView(instructionModel: InstructionSearchViewModel(id: model.foundRecipes[i].id ?? 777), ingredientInfo: IngredientsInformation(recipe: model.foundRecipes[i]), recipeName: model.foundRecipes[i].title ?? "Placeholder"), label: {
                        RecipeButtonView(recipeName: model.foundRecipes[i].title ?? "Placeholder")
                    })
                }
                
                else {
                    if (twoSquares(loop: i)) {
                        HStack {
                            NavigationLink(destination: RecipeDetailsView(instructionModel: InstructionSearchViewModel(id: model.foundRecipes[i].id ?? 777), ingredientInfo: IngredientsInformation(recipe: model.foundRecipes[i]), recipeName: model.foundRecipes[i].title ?? "Placeholder"), label: {
                                RecipeButtonView(recipeName: model.foundRecipes[i].title ?? "Placeholder")
                            })
                            NavigationLink(destination: RecipeDetailsView(instructionModel: InstructionSearchViewModel(id: model.foundRecipes[i-1].id ?? 777), ingredientInfo: IngredientsInformation(recipe: model.foundRecipes[i-1]), recipeName: model.foundRecipes[i-1].title ?? "Placeholder"), label: {
                                RecipeButtonView(recipeName: model.foundRecipes[i-1].title ?? "Placeholder")
                            })
                        }
                    } else {
                        EmptyView()
                    }
                }
            }
        }.navigationTitle("Recipe Search") // Title at the top of the page
    }
}
