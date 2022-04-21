//
//  CookbookView.swift
//  Tastepedia (iOS)
//
//  Created by Caleb Ross on 4/14/22.
//

import SwiftUI

struct CookbookView: View {
    // Access the cookbook environment object
    @EnvironmentObject var cookbook: Cookbook
    
    var body: some View {
        ScrollView {
            if cookbook.savedRecipes.count == 0 {
                Text("No Recipes Saved")
            }
            else {
                // Display each saved recipe in a grid
                ForEach(0 ..< cookbook.savedRecipes.count, id: \.self) { i in
                    if (oneSquare(loop: i, count: cookbook.savedRecipes.count)) {
                        RecipeButtonView(tappable: true, recipe: ObservableRecipe(cookbook.savedRecipes[i].id, cookbook.savedRecipes[i].name, cookbook.savedRecipes[i].ingredients, cookbook.savedRecipes[i].instructions))
                    }
                    
                    else {
                        if (twoSquares(loop: i)) {
                            HStack {
                                RecipeButtonView(tappable: true, recipe: ObservableRecipe(cookbook.savedRecipes[i].id, cookbook.savedRecipes[i].name, cookbook.savedRecipes[i].ingredients, cookbook.savedRecipes[i].instructions))
                                RecipeButtonView(tappable: true, recipe: ObservableRecipe(cookbook.savedRecipes[i-1].id, cookbook.savedRecipes[i-1].name, cookbook.savedRecipes[i-1].ingredients, cookbook.savedRecipes[i-1].instructions))
                            }
                        } else {
                            EmptyView()
                        }
                    }
                }
            }
        }.navigationTitle("Your Cookbook") // Title at the top of the page
    }
}

struct CookbookView_Previews: PreviewProvider {
    static var previews: some View {
        CookbookView()
    }
}
