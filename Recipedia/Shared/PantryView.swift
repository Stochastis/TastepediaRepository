//
//  PantryView.swift
//  Recipedia (iOS)
//
//  Created by Caleb Ross on 3/17/22.
//

import SwiftUI

struct PantryView: View {
    
    // Required so that this view can be 'dismissed' with a closure
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // Create ObservedObject for list of ingredients in pantry
    @ObservedObject var pantry: Pantry
    
    var body: some View {
        // Wrap everything in a NavigationView so that pages can easily be navigated between
        NavigationView{
            VStack {
                HStack {
                    Button(action: {
                        // Dismiss this current view and return to the previous one
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "note")
                    })
                    Text("This is the PantryView.")
                }
                Spacer()
                ScrollView {
                    // List out all ingredients in the pantry
                    ForEach(0 ..< pantry.ingredients.count) { i in
                        
                        // Checks if this is the last ingredient in the pantry and displays a singular, larger square for it
                        if (checkForOneSquare(loop: i, count: pantry.ingredients.count)) {
                            ZStack {
                                Rectangle().aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                Text("\(pantry.ingredients[i])").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            }
                        }
                        
                        // Displays two squares for all ingredients in the pantry
                        else {
                            if (checkForTwoSquares(loop: i)) {
                                HStack {
                                    ZStack {
                                        Rectangle().aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                        Text("\(pantry.ingredients[i-1])").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                    }
                                    ZStack {
                                        Rectangle().aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                        Text("\(pantry.ingredients[i])").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
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

fileprivate func checkForOneSquare(loop: Int, count: Int) -> Bool {
    let first: Bool = ((count - loop) == 1)
    let second: Bool = (count % 2 == 1)
    let final: Bool = (first && second)
    return final
}

fileprivate func checkForTwoSquares(loop: Int) -> Bool {
    return (loop % 2 == 1)
}

struct PantryView_Previews: PreviewProvider {
    static var previews: some View {
        PantryView(pantry: Pantry(startingIngredients: ["Salt", "Garlic", "Peppers", "Avacado", "Beef"]))
    }
}
