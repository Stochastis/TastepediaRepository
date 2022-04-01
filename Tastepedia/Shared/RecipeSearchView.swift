//
//  SearchView.swift
//  Tastepedia (iOS)
//
//  Created by Caleb Ross on 3/17/22.
//

import SwiftUI

struct SearchView: View {
    // Required so that this view can be 'dismissed' with a closure
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    // A variable for keeping track of the phone's current color scheme
    @Environment(\.colorScheme) var colorScheme
    
    // Used to store the titles of recipes gathered from the API call
    @State var recipes: [String] = []
        
    // Create a View Model to interact with the API
    @StateObject var model = RecipeSearchViewModel()
    
    // Access the pantry environment object
    @EnvironmentObject var pantry: Pantry
        
    var body: some View {
        // Wrap everything in a NavigationView so that pages can easily be navigated between
        NavigationView{
            VStack {
                // Recipe search and Back buttons
                HStack {
                    // Grabs recipes from the Spoonacular API through the ViewModel
                    Button(action: {
                        model.findRecipes(inputs: pantry.ingredients)
                        recipes.removeAll()
                        for index in 0..<(model.foundRecipes.count) {
                            recipes.append(model.foundRecipes[index].title ?? "Placeholder Recipe Title")
                        }
                    }, label: {
                        Text("Search For Recipes")
                    })
                    
                    // Dismiss this current view and return to the previous one
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "note").foregroundColor(colorScheme == .dark ? .white : .black)
                    })
                }
                Spacer()
                ScrollView {
                    ForEach(0 ..< model.foundRecipes.count, id: \.self) { i in
                        if (oneSquare(loop: i, count: model.foundRecipes.count)) {
                            ZStack {
                                Rectangle().aspectRatio(1, contentMode: .fill)
                                Text(model.foundRecipes[i].title ?? "Placeholder").foregroundColor(.orange)
                            }
                        }
                        
                        else {
                            if (twoSquares(loop: i)) {
                                HStack {
                                    ZStack {
                                        Rectangle().aspectRatio(1, contentMode: .fill)
                                        Text(model.foundRecipes[i-1].title ?? "Placeholder").foregroundColor(.orange)
                                    }
                                    ZStack {
                                        Rectangle().aspectRatio(1, contentMode: .fill)
                                        Text(model.foundRecipes[i].title ?? "Placeholder").foregroundColor(.orange)
                                    }
                                }
                            } else {
                                EmptyView()
                            }
                        }
                    }
                }
                Spacer()
            }
        }.navigationBarHidden(true)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
