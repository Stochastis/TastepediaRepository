//
//  PISquareView.swift
//  Tastepedia (iOS)
//
//  Created by Caleb Ross on 3/24/22.
//
//  A square that contains an ingredient and a button that can add/remove that ingredient from the user's Pantry

import SwiftUI

struct PISquareView: View {
    // Access the pantry environment object
    @EnvironmentObject var pantry: Pantry
    
    @Binding var textsToShow: [String]
    
    let index: Int
    
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        if (index < textsToShow.count) {
            ZStack {
                Rectangle().aspectRatio(1, contentMode: .fill)
                Text("\(textsToShow[index].capitalized)").foregroundColor(.orange)
                Button(action: {
                    // Store the ingredient in a variable for easy access later
                    let selectedIngredient: String = textsToShow[index]
                    
                    // Adds ingredient if not already in pantry
                    if !(pantry.ingredients.contains(selectedIngredient)) {
                        pantry.addIngredient(selectedIngredient)
                        print("Added \(selectedIngredient) to pantry")
                    }
                    
                    // Removes ingredient if already in pantry
                    else {
                        print("Pantry already contains \(selectedIngredient).")
                        print("Removing \(selectedIngredient) from pantry.")
                        pantry.removeIngredient(selectedIngredient)
                        print("Removed \(selectedIngredient) from pantry.")
                    }
                }, label: {
                    // Green plus if not in pantry. Red minus if in pantry.
                    if !(pantry.ingredients.contains(textsToShow[index])) {
                        Image(systemName: "plus.square.fill").foregroundColor(.green)
                    } else {
                        Image(systemName: "minus.square.fill").foregroundColor(.red)
                    }
                }).frame(width: width, height: height, alignment: .bottomLeading)
            }
        }
    }
}
