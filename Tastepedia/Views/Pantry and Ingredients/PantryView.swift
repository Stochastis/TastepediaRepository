//
//  PantryView.swift
//  Tastepedia (iOS)
//
//  Created by Caleb Ross on 3/17/22.
//
//  A view that displays a user's Pantry and allows them to remove ingredients from it

import SwiftUI

struct PantryView: View {
    // A variable for keeping track of the phone's current color scheme
    @Environment(\.colorScheme) var colorScheme
    
    // Required so that this view can be 'dismissed' with a closure
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // Access the pantry environment object
    @EnvironmentObject var pantry: Pantry
    
    var body: some View {
        VStack {
            ScrollView {
                if (pantry.ingredients.count != 0) {
                    // If there is an even number of results
                    if (pantry.ingredients.count % 2 == 0) {
                        ForEach((0 ..< pantry.ingredients.count), id: \.self) { i in
                            if (i % 2 == 0) {
                                HStack{
                                    PISquareView(textsToShow: $pantry.ingredients, index: i, width: 150, height: 150)
                                    PISquareView(textsToShow: $pantry.ingredients, index: i+1, width: 150, height: 150)
                                }
                            }
                        }
                    }
                    // If there is an odd number of results
                    else {
                        ForEach((0 ..< pantry.ingredients.count), id: \.self) { i in
                            if (i != (pantry.ingredients.count - 1)) {
                                if (i % 2 == 0) {
                                    HStack{
                                        PISquareView(textsToShow: $pantry.ingredients, index: i, width: 150, height: 150)
                                        PISquareView(textsToShow: $pantry.ingredients, index: i+1, width: 150, height: 150)
                                    }
                                }
                            }
                            else {
                                PISquareView(textsToShow: $pantry.ingredients, index: i, width: 300, height: 300)
                            }
                        }
                    }
                }
                else {
                    EmptyView()
                }
            }
        }.navigationTitle("Your Pantry").toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing, content: {
                // Essentially a button that uses the functionality of NavigationView to go between different views
                NavigationLink(
                    destination: IngredientSearchView(),
                    label: {
                        Image(systemName: "plus").foregroundColor(colorScheme == .dark ? .white : .black)
                    })
            })
        })
    }
}

struct PantryView_Previews: PreviewProvider {
    static var previews: some View {
        PantryView().environmentObject(Pantry())
    }
}
