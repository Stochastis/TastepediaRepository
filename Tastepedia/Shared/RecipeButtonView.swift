//
//  RecipeButton.swift
//  Tastepedia (iOS)
//
//  Created by Caleb Ross on 4/1/22.
//

import SwiftUI

struct RecipeButton: View {
    // A variable for keeping track of the phone's current color scheme
    @Environment(\.colorScheme) var colorScheme

    // Create a View Model to interact with the API
    @StateObject var model: RecipeSearchViewModel
    
    let index: Int
    
    var body: some View {
        Button(action: {
            print("Button Pressed")
        }, label: {
            ZStack {
                Rectangle().aspectRatio(1, contentMode: .fill).foregroundColor(colorScheme == .dark ? .white : .black)
                Text(model.foundRecipes[index].title ?? "Placeholder").foregroundColor(.orange)
            }
        })
    }
}
