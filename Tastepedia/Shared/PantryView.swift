//
//  PantryView.swift
//  Tastepedia (iOS)
//
//  Created by Caleb Ross on 3/17/22.
//

import SwiftUI

struct PantryView: View {
    // A variable for keeping track of the phone's current color scheme
    @Environment(\.colorScheme) var colorScheme

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
                        Image(systemName: "note").foregroundColor(colorScheme == .dark ? .white : .black)
                    })
                    Text("This is your digital pantry.")
                    
                    // Essentially a button that uses the functionality of NavigationView to go between different views
                    NavigationLink(
                        destination: IngredientSearchView(),
                        label: {
                            Image(systemName: "magnifyingglass").foregroundColor(colorScheme == .dark ? .white : .black)
                        })
                }
                Spacer()
                ScrollView {
                    if (pantry.ingredients.count != 0) {
                        // If there is an even number of results
                        if (pantry.ingredients.count % 2 == 0) {
                            ForEach((0 ..< pantry.ingredients.count), id: \.self) { i in
                                if (i % 2 == 0) {
                                    HStack{
                                        PIViewSquare(textsToShow: $pantry.ingredients, index: i, width: 150, height: 150)
                                        PIViewSquare(textsToShow: $pantry.ingredients, index: i+1, width: 150, height: 150)
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
                                            PIViewSquare(textsToShow: $pantry.ingredients, index: i, width: 150, height: 150)
                                            PIViewSquare(textsToShow: $pantry.ingredients, index: i+1, width: 150, height: 150)
                                        }
                                    }
                                }
                                else {
                                    PIViewSquare(textsToShow: $pantry.ingredients, index: i, width: 300, height: 300)
                                }
                            }
                        }
                    }
                    else {
                        EmptyView()
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
