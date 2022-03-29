//
//  IngredientSearchScrollView.swift
//  Tastepedia (iOS)
//
//  Created by Caleb Ross on 3/24/22.
//

import SwiftUI

struct IngredientSearchScrollView: View {
    @EnvironmentObject var ingredientsList: IngredientsFile
    
    @Binding var searchQuery: String
    
    var body: some View {
        ScrollView {
            // Don't make this filter any longer. Indexing takes to long.
            ForEach((0 ..< ingredientsList.ingredientsList.count).filter({ ingredientsList.ingredientsList[$0].localizedCaseInsensitiveContains(searchQuery) }), id: \.self) { i in
                
                if (checkForOneSquare(loop: i, count: ingredientsList.ingredientsList.count)) {
                    IngredientSearchScrollViewOneSquare(index: i)
                }
                
                // Displays two squares for all ingredients in the list except for the last one if there is an odd number of indgredients
                else {
                    if (checkForTwoSquares(loop: i)) {
                        IngredientSearchScrollViewTwoSquares(index: i)
                    } else {
                        EmptyView()
                    }
                }
            }
        }
    }
}
