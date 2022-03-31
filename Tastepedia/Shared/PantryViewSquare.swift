//
//  PantryViewSquare.swift
//  Tastepedia (iOS)
//
//  Created by Caleb Ross on 3/30/22.
//

import SwiftUI

struct PantryViewSquare: View {
    @State var i: Int
    
    // Access the pantry environment object
    @EnvironmentObject var pantry: Pantry
    
    // Easier access to UserDefaults
    let storedData = UserDefaults.standard
    
    var body: some View {
        ZStack {
            Rectangle().aspectRatio(1, contentMode: .fill)
            Text("\(pantry.ingredients[i].capitalized)").foregroundColor(.orange)
            Button(action: {
                print("Removing \(pantry.ingredients[i]) from pantry.")
                pantry.ingredients.remove(at: i)
                storedData.set(pantry.ingredients, forKey: "savedIngredients")
            }, label: {
                Image(systemName: "minus.square.fill").foregroundColor(.red)
            }).frame(width: 150, height: 150, alignment: .bottomLeading)
        }
    }
}
