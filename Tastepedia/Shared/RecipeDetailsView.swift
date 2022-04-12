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
    
//    let picture: UIImage
    
    var body: some View {
        ScrollView {
//            Image(uiImage: picture)
            Text("Ingredients:")
            // Recipe ingredients
            ForEach(0 ..< ingredients.names.count, id: \.self) { i in
                Text("\(ingredients.amounts[i]) \(ingredients.units[i]) of \(ingredients.names[i])").frame(width: 350, height: 50, alignment: .leading)
            }
            Divider()
            
            // Recipe instructions
            Text("Steps:")
            ForEach(0 ..< model.instructions[0].steps!.count, id: \.self) { i in
                VStack {
                    Text("Step \(i+1):").padding([.top])
                    Text(model.instructions[0].steps![i].step!)
                        .padding([.leading, .bottom, .trailing])
                }
            }
        }
    }
}
