//
//  RecipeDetailsView.swift
//  Tastepedia (iOS)
//
//  Created by Caleb Ross on 4/1/22.
//
//  A view to display a recipe's details and give the users the option to save the recipe for later

import SwiftUI

struct RecipeDetailsView: View {
    // A variable for keeping track of the phone's current color scheme
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject var recipe: ObservableRecipe
    
    // Access the application's cookbook environment object
    @EnvironmentObject var cookbook: Cookbook
    
    var body: some View {
        ScrollView {
            // Recipe ingredients
            LazyVStack(pinnedViews: .sectionHeaders) {
                Section(header: Text("Ingredients").frame(width: 350, height: 25, alignment: .center).background(Color.orange)) {
                    ForEach(0 ..< recipe.ingredients.names.count, id: \.self) { i in
                        Text("\(formattedIngredient(recipe.ingredients.amounts[i], recipe.ingredients.units[i], recipe.ingredients.names[i]))").frame(width: 350, height: 50, alignment: .leading)
                    }
                }
            }
            
            // Recipe instructions
            LazyVStack(pinnedViews: .sectionHeaders) {
                Section(header: Text("Instructions").frame(width: 350, height: 25, alignment: .center).background(Color.orange)) {
                    ForEach(0 ..< recipe.instructions.steps!.count, id: \.self) { i in
                        VStack {
                            Text("Step \(i+1):").padding([.top])
                            Text(recipe.instructions.steps![i].step!)
                                .padding([.leading, .bottom, .trailing])
                        }
                    }
                }
            }.onAppear(perform: {
                recipe.getInstructions()
            })
        }.navigationBarTitleDisplayMode(.inline).navigationTitle(recipe.name).toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing, content: {
                if cookbook.savedRecipes.contains(Recipe(id: recipe.id, name: recipe.name, ingredients: recipe.ingredients, instructions: recipe.instructions)) {
                    Image(systemName: "square.and.arrow.down.fill").foregroundColor(colorScheme == .dark ? .white : .black).onTapGesture {
                        cookbook.removeRecipe(recipe.id)
                        print("Unsaved Recipe")
                    }
                } else {
                    Image(systemName: "square.and.arrow.down").foregroundColor(colorScheme == .dark ? .white : .black).onTapGesture {
                        cookbook.addReipe(Recipe(id: recipe.id, name: recipe.name, ingredients: recipe.ingredients, instructions: recipe.instructions))
                    }
                }
            })
        })
    }
}

let specialIngredients = [
    "String Cheese" : "Sticks",
    "Lemons" : "",
    "Lemon Rind" : "",
    "Eggs" : "",
    "Onions" : ""
]

func formattedAmount(_ unformatted: String) -> String {
    let wholeDouble = Double(unformatted)?.rounded(.down)
    let wholeInt = Int(wholeDouble!)
    var fraction = ""
    switch Double(unformatted)?.truncatingRemainder(dividingBy: 1.0) {
    case 0.1:
        fraction = "1/10"
    case 0.125:
        fraction = "1/8"
    case 0.2:
        fraction = "1/5"
    case 0.25:
        fraction = "1/4"
    case 0.3:
        fraction = "3/10"
    case 1/3:
        fraction = "1/3"
    case 0.375:
        fraction = "3/8"
    case 0.4:
        fraction = "2/5"
    case 0.5:
        fraction = "1/2"
    case 0.6:
        fraction = "3/5"
    case 0.625:
        fraction = "5/8"
    case 2/3:
        fraction = "2/3"
    case 0.7:
        fraction = "7/10"
    case 0.75:
        fraction = "3/4"
    case 0.8:
        fraction = "4/5"
    case 0.875:
        fraction = "7/8"
    case 0.9:
        fraction = "9/10"
    case .none:
        fraction = ""
    case .some(_):
        fraction = ""
    }
    return (wholeInt == 0) ? fraction : String(String(wholeInt) + " " + fraction)
}

func formattedIngredient(_ unformattedAmount: String, _ units: String, _ name: String) -> String {
    let finalAmount = formattedAmount(unformattedAmount)
    let finalUnits = (specialIngredients.keys.contains(name.capitalized)) ? specialIngredients[name.capitalized] : units.capitalized
    let finalName = name.capitalized
    return "\(finalAmount) \(finalUnits!) \(finalUnits == "" ? "" : "of ")\(finalName)"
}
