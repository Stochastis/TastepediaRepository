//
//  SearchView.swift
//  Tastepedia (iOS)
//
//  Created by Caleb Ross on 3/17/22.
//

import SwiftUI

struct SearchView: View {
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
        // Wrap everything in a NavigationView so that pages can easily be navigated between
        VStack {
            // Show all the recipe results
            ScrollView {
                // Grabs recipes from the Spoonacular API through the ViewModel
                Button(action: {
                    model.findRecipes(inputs: pantry.ingredients)
                    recipes.removeAll()
                    for index in 0..<(model.foundRecipes.count) {
                        recipes.append(model.foundRecipes[index].title ?? "Placeholder Recipe Title")
                    }
                }, label: {
                    Text("Tap Here To Search For Recipes")
                })
                
                ForEach(0 ..< model.foundRecipes.count, id: \.self) { i in
                    if (oneSquare(loop: i, count: model.foundRecipes.count)) {
                        RecipeButtonView(model: model, ingredients: IngredientsInformation(recipe: model.foundRecipes[i]), index: i)
                    }
                    
                    else {
                        if (twoSquares(loop: i)) {
                            HStack {
                                RecipeButtonView(model: model, ingredients: IngredientsInformation(recipe: model.foundRecipes[i-1]), index: i-1)
                                RecipeButtonView(model: model, ingredients: IngredientsInformation(recipe: model.foundRecipes[i]), index: i)
                            }
                        } else {
                            EmptyView()
                        }
                    }
                }
            }
            Spacer()
        }.navigationTitle("Recipe Search")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
