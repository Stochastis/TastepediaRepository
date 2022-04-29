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
        List(cookbook.savedRecipes) {
            NavigationLink($0.name, destination: RecipeDetailsView(recipe: ObservableRecipe($0.id, $0.name, $0.ingredients, $0.instructions)))
        }.navigationTitle("Your Cookbook") // Title at the top of the page
    }
}

struct CookbookView_Previews: PreviewProvider {
    static var previews: some View {
        CookbookView()
    }
}
