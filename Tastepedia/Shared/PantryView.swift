//
//  PantryView.swift
//  Tastepedia (iOS)
//
//  Created by Caleb Ross on 3/17/22.
//

import SwiftUI

struct PantryView: View {
    
    // Required so that this view can be 'dismissed' with a closure
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // Access the pantry environment object
    @EnvironmentObject var pantry: Pantry
    
    var body: some View {
        // Wrap everything in a NavigationView so that pages can easily be navigated between
        NavigationView{
            VStack {
                HStack {
                    Button(action: {
                        // Dismiss this current view and return to the previous one
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "note").foregroundColor(.black)
                    })
                    Text("This is the PantryView.")
                    
                    // Essentially a button that uses the functionality of NavigationView to go between different views
                    NavigationLink(
                        destination: IngredientSearchView(),
                        label: {
                            Image(systemName: "magnifyingglass").foregroundColor(.black)
                        })
                }
                Spacer()
                ScrollView {
                    // List out all ingredients in the pantry
                    ForEach(0 ..< pantry.ingredients.count, id: \.self) { i in
                        
                        // Checks if this is the last ingredient in the pantry and displays a singular, larger square for it
                        if (checkForOneSquare(loop: i, count: pantry.ingredients.count)) {
                            ZStack {
                                Rectangle().aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                Text("\(pantry.ingredients[i])").foregroundColor(.orange)
                                Button(action: {
                                    print("Removed \(pantry.ingredients[i]) from pantry.")
                                    pantry.ingredients.remove(at: i)
                                }, label: {
                                    Image(systemName: "minus.square.fill").foregroundColor(.red)
                                }).frame(width: 300, height: 300, alignment: .bottomLeading)
                            }
                        }
                        
                        // Displays two squares for all ingredients in the pantry except for the last one if there is an odd number of indgredients
                        else {
                            // Check if this if statement is necessary
                            if (checkForTwoSquares(loop: i)) {
                                HStack {
                                    ZStack {
                                        Rectangle().aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                        Text("\(pantry.ingredients[i-1])").foregroundColor(.orange)
                                        Button(action: {
                                            print("Removed \(pantry.ingredients[i-1]) from pantry.")
                                            pantry.ingredients.remove(at: i-1)
                                        }, label: {
                                            Image(systemName: "minus.square.fill").foregroundColor(.red)
                                        }).frame(width: 150, height: 150, alignment: .bottomLeading)
                                    }
                                    ZStack {
                                        Rectangle().aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                        Text("\(pantry.ingredients[i])").foregroundColor(.orange)
                                        Button(action: {
                                            print("Removed \(pantry.ingredients[i]) from pantry.")
                                            pantry.ingredients.remove(at: i)
                                        }, label: {
                                            Image(systemName: "minus.square.fill").foregroundColor(.red)
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

struct PantryView_Previews: PreviewProvider {
    static var previews: some View {
        PantryView().environmentObject(Pantry(startingIngredients: []))
    }
}
