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
    
    let storedData = UserDefaults.standard
    
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
                    Text("This is your digital pantry.")
                    
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
                        if (oneSquare(loop: i, count: pantry.ingredients.count)) {
                            PantryViewSquare(i: i)
                        }
                        
                        // Displays two squares for all ingredients in the pantry except for the last one if there is an odd number of indgredients
                        else {
                            // Check if this if statement is necessary
                            if (twoSquares(loop: i)) {
                                HStack {
                                    PantryViewSquare(i: i-1)
                                    PantryViewSquare(i: i)
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

struct PantryView_Previews: PreviewProvider {
    static var previews: some View {
        PantryView().environmentObject(Pantry())
    }
}
