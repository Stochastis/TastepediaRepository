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
    
    let tappable: Bool
    
    @StateObject var recipe: ObservableRecipe
    
    var body: some View {
        if (tappable) {
            NavigationLink(destination: RecipeDetailsView(recipe: recipe), label: {
                            ZStack {
                                Rectangle().aspectRatio(1, contentMode: .fill).foregroundColor(colorScheme == .dark ? .white : .black)
                                // Name of the recipe
                                Text(recipe.name).foregroundColor(.orange)
                            }}
            )
        } else {
            ZStack {
                Rectangle().aspectRatio(1, contentMode: .fill).foregroundColor(colorScheme == .dark ? .white : .black)
                // Name of the recipe
                Text(recipe.name).foregroundColor(.orange)
            }
        }
    }
}
