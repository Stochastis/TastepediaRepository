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
                        Text("\(recipe.ingredients.amounts[i]) \(recipe.ingredients.units[i].capitalized) of \(recipe.ingredients.names[i].capitalized)").frame(width: 350, height: 50, alignment: .leading)
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
                                .padding([.leading, .bottom, .trailing]).onChange(of: recipe.instructions.steps![i].step!, perform: {_ in
                                    print("Something changed")
                                })
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
                        print("Saved Recipe")
                    }
                }
            })
        })
    }
}
