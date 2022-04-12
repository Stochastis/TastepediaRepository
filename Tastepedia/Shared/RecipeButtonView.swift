//
//  RecipeButton.swift
//  Tastepedia (iOS)
//
//  Created by Caleb Ross on 4/1/22.
//

import SwiftUI

struct RecipeButtonView: View {
    // A variable for keeping track of the phone's current color scheme
    @Environment(\.colorScheme) var colorScheme
    
    @State var tapped = false
    
//    @State var picture = UIImage()
    
    // Create a View Model to interact with the API
    @StateObject var model: RecipeSearchViewModel
    
    @StateObject var instructionModel = InstructionSearchViewModel()
    
    @StateObject var ingredients: IngredientsInformation
    
    let index: Int
    
    var body: some View {
        ZStack {
            Rectangle().aspectRatio(1, contentMode: .fill).foregroundColor(colorScheme == .dark ? .white : .black).onTapGesture {
                instructionModel.findInstructions(id: model.foundRecipes[index].id ?? 777)
//                let image1 = UIImageView()
//                image1.loadFrom(URLAddress: "https://spoonacular.com/recipeImages/644677-312x231.jpg")
//                picture = image1.image!
                tapped.toggle()
            }
            // Name of the recipe
            Text(model.foundRecipes[index].title ?? "Placeholder").foregroundColor(.orange).onTapGesture {
                instructionModel.findInstructions(id: model.foundRecipes[index].id ?? 777)
                tapped.toggle()
            }
            NavigationLink("", destination: RecipeDetailsView(model: instructionModel, ingredients: ingredients), isActive: $tapped)
        }
    }
}
