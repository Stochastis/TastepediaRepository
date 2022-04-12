//
//  RecipeDetailsView.swift
//  Tastepedia (iOS)
//
//  Created by Caleb Ross on 4/1/22.
//

import SwiftUI

struct RecipeDetailsView: View {
    
    // Create a View Model to interact with the API
    @StateObject var recipeInstructions: InstructionSearchViewModel
    
    let ingredientInfo: IngredientsInformation
    
    let recipeName: String
    
    //let picture: UIImage
    
    var body: some View {
        ScrollView {
            //Image(uiImage: picture)
            // Recipe ingredients
            LazyVStack(pinnedViews: .sectionHeaders) {
                Section(header: Text("Ingredients").frame(width: 350, height: 25, alignment: .center).background(Color.orange)) {
                    ForEach(0 ..< ingredientInfo.names.count, id: \.self) { i in
                        Text("\(ingredientInfo.amounts[i]) \(ingredientInfo.units[i].capitalized) of \(ingredientInfo.names[i].capitalized)").frame(width: 350, height: 50, alignment: .leading)
                    }
                }
            }
            
            // Recipe instructions
            LazyVStack(pinnedViews: .sectionHeaders) {
                Section(header: Text("Instructions").frame(width: 350, height: 25, alignment: .center).background(Color.orange)) {
                    ForEach(0 ..< recipeInstructions.instructions[0].steps!.count, id: \.self) { i in
                        VStack {
                            Text("Step \(i+1):").padding([.top])
                            Text(recipeInstructions.instructions[0].steps![i].step!)
                                .padding([.leading, .bottom, .trailing])
                        }
                    }
                }
            }
        }.navigationBarTitleDisplayMode(.inline).navigationTitle(recipeName)
    }
}
