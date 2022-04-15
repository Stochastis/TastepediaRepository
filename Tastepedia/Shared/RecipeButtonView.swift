//
//  RecipeButton.swift
//  Tastepedia (iOS)
//
//  Created by Caleb Ross on 4/1/22.
//
//  A rectangle with a given recipe's name on top

import SwiftUI

struct RecipeButtonView: View {
    // A variable for keeping track of the phone's current color scheme
    @Environment(\.colorScheme) var colorScheme
    
    let recipeName: String
    
    let model: RecipeSearchViewModel
    
    let i: Int
    
    var body: some View {
        NavigationLink(destination: RecipeDetailsView(downloaded: true, instructionModel: InstructionSearchViewModel(id: model.foundRecipes[i].id ?? 777), ingredientInfo: IngredientsInformation(recipe: model.foundRecipes[i]), recipeName: model.foundRecipes[i].title ?? "Placeholder", id: model.foundRecipes[i].id ?? 777), label: {
                        ZStack {
                            Rectangle().aspectRatio(1, contentMode: .fill).foregroundColor(colorScheme == .dark ? .white : .black)
                            // Name of the recipe
                            Text(recipeName).foregroundColor(.orange)
                        }}
        )
    }
}
