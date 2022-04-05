//
//  RecipeDetailsView.swift
//  Tastepedia (iOS)
//
//  Created by Caleb Ross on 4/1/22.
//

import SwiftUI

struct RecipeDetailsView: View {
    
    // Create a View Model to interact with the API
    @StateObject var model: InstructionSearchViewModel
    
    let ingredients: IngredientsInformation
    
    var body: some View {
        ScrollView {
            ForEach(0 ..< ingredients.names.count, id: \.self) { i in
                Text("\(ingredients.amounts[i]) \(ingredients.units[i]) of \(ingredients.names[i])")
            }
            ForEach(0 ..< model.instructions[0].steps!.count, id: \.self) { i in
                VStack {
                    Text("Step \(i+1):")
                    Text(model.instructions[0].steps![i].step!)
                        .padding([.leading, .bottom, .trailing])
                }
            }
        }
    }
}
