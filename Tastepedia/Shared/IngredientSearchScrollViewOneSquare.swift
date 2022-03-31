//
//  IngredientSearchScrollViewOneSquare.swift
//  Tastepedia (iOS)
//
//  Created by Caleb Ross on 3/24/22.
//

import SwiftUI

struct IngredientSearchScrollViewOneSquare: View {
    // Access the pantry environment object
    @EnvironmentObject var pantry: Pantry
    
    @Binding var filteredIngredients: [String]
    
    let index: Int
    
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        if (index < filteredIngredients.count) {
            ZStack {
                Rectangle().aspectRatio(1, contentMode: .fill)
                Text("\(filteredIngredients[index].capitalized)").foregroundColor(.orange)
                Button(action: {
                    // Store the ingredient in a variable for easy access later
                    let selectedIngredient: String = filteredIngredients[index]
                    
                    // Adds ingredient if not already in pantry
                    if !(pantry.ingredients.contains(selectedIngredient)) {
                        print("Added \(selectedIngredient) to pantry")
                        pantry.addIngredient(selectedIngredient)
                    }
                    
                    // Removes ingredient if already in pantry
                    else {
                        print("Pantry already contains \(selectedIngredient)")
                        print("Removing \(selectedIngredient) from pantry")
                        pantry.removeIngredient(selectedIngredient)
                    }
                }, label: {
                    // Green plus if not in pantry. Red minus if in pantry.
                    if !(pantry.ingredients.contains(filteredIngredients[index])) {
                        Image(systemName: "plus.square.fill").foregroundColor(.green)
                    } else {
                        Image(systemName: "minus.square.fill").foregroundColor(.red)
                    }
                }).frame(width: width, height: height, alignment: .bottomLeading)
            }
        }
    }
}
