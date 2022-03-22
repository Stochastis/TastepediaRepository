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
                        Button(action: {
                            print("Button pressed")
                        }, label: {
                            Image(systemName: "magnifyingglass").foregroundColor(.black)
                        })
                        
                        TextField("Enter an ingredient...", text: $searchQuery)
                    }.padding(.vertical, 10).padding(.horizontal).background(Color.primary.opacity(0.05)).cornerRadius(8).padding(.horizontal)
                }
                Spacer()
                ScrollView {
                    ForEach((0 ..< ingredientsList.ingredientsList.count).filter({ ingredientsList.ingredientsList[$0].contains(searchQuery) }), id: \.self) { i in
                        
                        if (checkForOneSquare(loop: i, count: ingredientsList.ingredientsList.count)) {
                            ZStack {
                                Rectangle().aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                Text("\(ingredientsList.ingredientsList[i])").foregroundColor(.orange)
                                Button(action: {
                                    if !(pantry.ingredients.contains(ingredientsList.ingredientsList[i])) {
                                        print("Added \(ingredientsList.ingredientsList[i]) to pantry")
                                        pantry.ingredients.append(ingredientsList.ingredientsList[i])
                                    } else {
                                        print("Pantry already contains \(ingredientsList.ingredientsList[i])")
                                    }
                                }, label: {
                                    Image(systemName: "plus.square.fill").foregroundColor(.green)
                                }).frame(width: 300, height: 300, alignment: .bottomLeading)
                            }
                        }
                        
                        // Displays two squares for all ingredients in the list except for the last one if there is an odd number of indgredients
                        else {
                            if (checkForTwoSquares(loop: i)) {
                                HStack {
                                    ZStack {
                                        Rectangle().aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                        Text("\(ingredientsList.ingredientsList[i-1])").foregroundColor(.orange)
                                        Button(action: {
                                            if !(pantry.ingredients.contains(ingredientsList.ingredientsList[i-1])) {
                                                print("Added \(ingredientsList.ingredientsList[i-1]) to pantry")
                                                pantry.ingredients.append(ingredientsList.ingredientsList[i-1])
                                            } else {
                                                print("Pantry already contains \(ingredientsList.ingredientsList[i-1])")
                                            }
                                        }, label: {
                                            Image(systemName: "plus.square.fill").foregroundColor(.green)
                                        }).frame(width: 150, height: 150, alignment: .bottomLeading)
                                    }
                                    ZStack {
                                        Rectangle().aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                        Text("\(ingredientsList.ingredientsList[i])").foregroundColor(.orange)
                                        Button(action: {
                                            if !(pantry.ingredients.contains(ingredientsList.ingredientsList[i])) {
                                                print("Added \(ingredientsList.ingredientsList[i]) to pantry")
                                                pantry.ingredients.append(ingredientsList.ingredientsList[i])
                                            } else {
                                                print("Pantry already contains \(ingredientsList.ingredientsList[i])")
                                            }
                                        }, label: {
                                            Image(systemName: "plus.square.fill").foregroundColor(.green)
                                        }).frame(width: 150, height: 150, alignment: .bottomLeading)
                                    }
                                }
                            } else {
                                /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
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
