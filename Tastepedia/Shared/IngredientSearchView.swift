//
//  IngredientSearchView.swift
//  Tastepedia (iOS)
//
//  Created by Caleb Ross on 3/19/22.
//

import SwiftUI

struct IngredientSearchView: View {
    
    // Required so that this view can be 'dismissed' with a closure
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State fileprivate var searchQuery = ""
    
    @EnvironmentObject var ingredientsList: IngredientsFile
    
    @EnvironmentObject var pantry: Pantry
    
    // For easier access to UserDefaults
    let storedData = UserDefaults.standard
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        // Dismiss this current view and return to the previous one
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "note").foregroundColor(.black)
                    })
                    
                    HStack {
                        Image(systemName: "magnifyingglass").foregroundColor(.black)
                        TextField("Enter an ingredient...", text: $searchQuery)
                    }.padding(.vertical, 10).padding(.horizontal).background(Color.primary.opacity(0.05)).cornerRadius(8).padding(.horizontal)
                }
                Spacer()
                ScrollView {
                    ForEach((0 ..< ingredientsList.ingredientsList.count).filter({ ingredientsList.ingredientsList[$0].contains(searchQuery) }), id: \.self) { i in
                        
                        if (checkForOneSquare(loop: i, count: ingredientsList.ingredientsList.count)) {
                            ZStack {
                                Rectangle().aspectRatio(1, contentMode: .fill)
                                Text("\(ingredientsList.ingredientsList[i])").foregroundColor(.orange)
                                Button(action: {
                                    // Store the ingredient in a variable for easy access later
                                    let selectedIngredient: String = ingredientsList.ingredientsList[i]
                                    
                                    // Adds ingredient if not already in pantry
                                    if !(pantry.ingredients.contains(selectedIngredient)) {
                                        print("Added \(selectedIngredient) to pantry")
                                        pantry.ingredients.append(selectedIngredient)
                                        storedData.set(pantry.ingredients, forKey: "savedIngredients")
                                    }
                                    
                                    // Removes ingredient if already in pantry
                                    else {
                                        print("Pantry already contains \(selectedIngredient)")
                                        print("Removing \(selectedIngredient) from pantry")
                                        pantry.ingredients.remove(at: pantry.ingredients.firstIndex(where: {$0 == selectedIngredient}) ?? 0)
                                        storedData.set(pantry.ingredients, forKey: "savedIngredients")
                                    }
                                }, label: {
                                    // Green plus if not in pantry. Red minus if in pantry.
                                    if !(pantry.ingredients.contains(ingredientsList.ingredientsList[i])) {
                                        Image(systemName: "plus.square.fill").foregroundColor(.green)
                                    } else {
                                        Image(systemName: "minus.square.fill").foregroundColor(.red)
                                    }
                                }).frame(width: 300, height: 300, alignment: .bottomLeading)
                            }
                        }
                        
                        // Displays two squares for all ingredients in the list except for the last one if there is an odd number of indgredients
                        else {
                            if (checkForTwoSquares(loop: i)) {
                                HStack {
                                    ZStack {
                                        Rectangle().aspectRatio(1, contentMode: .fill)
                                        Text("\(ingredientsList.ingredientsList[i-1])").foregroundColor(.orange)
                                        Button(action: {
                                            // Store the ingredient in a variable for easy access later
                                            let selectedIngredient: String = ingredientsList.ingredientsList[i-1]
                                            
                                            // Adds ingredient if not already in pantry
                                            if !(pantry.ingredients.contains(selectedIngredient)) {
                                                print("Added \(selectedIngredient) to pantry")
                                                pantry.ingredients.append(selectedIngredient)
                                                storedData.set(pantry.ingredients, forKey: "savedIngredients")
                                            }
                                            
                                            // Removes ingredient if already in pantry
                                            else {
                                                print("Pantry already contains \(selectedIngredient)")
                                                print("Removing \(selectedIngredient) from pantry")
                                                pantry.ingredients.remove(at: pantry.ingredients.firstIndex(where: {$0 == selectedIngredient}) ?? 0)
                                                storedData.set(pantry.ingredients, forKey: "savedIngredients")
                                            }
                                        }, label: {
                                            // Green plus if not in pantry. Red minus if in pantry.
                                            if !(pantry.ingredients.contains(ingredientsList.ingredientsList[i-1])) {
                                                Image(systemName: "plus.square.fill").foregroundColor(.green)
                                            } else {
                                                Image(systemName: "minus.square.fill").foregroundColor(.red)
                                            }
                                        }).frame(width: 150, height: 150, alignment: .bottomLeading)
                                    }
                                    ZStack {
                                        Rectangle().aspectRatio(1, contentMode: .fill)
                                        Text("\(ingredientsList.ingredientsList[i])").foregroundColor(.orange)
                                        Button(action: {
                                            // Store the ingredient in a variable for easy access later
                                            let selectedIngredient: String = ingredientsList.ingredientsList[i]
                                            
                                            // Adds ingredient if not already in pantry
                                            if !(pantry.ingredients.contains(selectedIngredient)) {
                                                print("Added \(selectedIngredient) to pantry")
                                                pantry.ingredients.append(selectedIngredient)
                                                storedData.set(pantry.ingredients, forKey: "savedIngredients")
                                            }
                                            
                                            // Removes ingredient if already in pantry
                                            else {
                                                print("Pantry already contains \(selectedIngredient)")
                                                print("Removing \(selectedIngredient) from pantry")
                                                pantry.ingredients.remove(at: pantry.ingredients.firstIndex(where: {$0 == selectedIngredient}) ?? 0)
                                                storedData.set(pantry.ingredients, forKey: "savedIngredients")
                                            }
                                        }, label: {
                                            // Green plus if not in pantry. Red minus if in pantry.
                                            if !(pantry.ingredients.contains(ingredientsList.ingredientsList[i])) {
                                                Image(systemName: "plus.square.fill").foregroundColor(.green)
                                            } else {
                                                Image(systemName: "minus.square.fill").foregroundColor(.red)
                                            }
                                        }).frame(width: 150, height: 150, alignment: .bottomLeading)
                                    }
                                }
                            } else {
                                EmptyView()
                            }
                        }
                    }
                }
            }
        }.navigationBarHidden(true)
    }
}

// Checks if there needs to be one big square for an odd number of ingredients in the pantry
// Using this function to minimize indexing time instead of doing this all in-line
fileprivate func checkForOneSquare(loop: Int, count: Int) -> Bool {
    let first: Bool = ((count - loop) == 1);
    let second: Bool = ((count % 2) == 1);
    let final: Bool = (first && second);
    return final;
}

// Checks if there needs to be two smaller squares for an even number of ingredients in the pantry
// Using this function to minimize indexing time instead of doing this all in-line
fileprivate func checkForTwoSquares(loop: Int) -> Bool {
    return (loop % 2 == 1)
}

struct IngredientSearchView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientSearchView().environmentObject(IngredientsFile())
    }
}
