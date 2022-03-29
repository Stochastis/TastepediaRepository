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
    
    // Access the MasterIngredientsList
    @EnvironmentObject var ingredientsList: IngredientsFile
    
    let index: Int

    var body: some View {
        ZStack {
            Rectangle().aspectRatio(1, contentMode: .fill)
            Text("\(ingredientsList.ingredientsList[index].capitalized)").foregroundColor(.orange)
            Button(action: {
                // Store the ingredient in a variable for easy access later
                let selectedIngredient: String = ingredientsList.ingredientsList[index]
                
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
                if !(pantry.ingredients.contains(ingredientsList.ingredientsList[index])) {
                    Image(systemName: "plus.square.fill").foregroundColor(.green)
                } else {
                    Image(systemName: "minus.square.fill").foregroundColor(.red)
                }
            }).frame(width: 300, height: 300, alignment: .bottomLeading)
        }
    }
}

struct IngredientSearchScrollViewOneSquare_Previews: PreviewProvider {
    static var previews: some View {
        IngredientSearchScrollViewOneSquare(index: 2)
    }
}
