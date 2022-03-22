//
//  SearchView.swift
//  Tastepedia (iOS)
//
//  Created by Caleb Ross on 3/17/22.
//

import SwiftUI

struct SearchView: View {
    
    // Used to store the titles of recipes gathered from the API call
    @State var recipes: [String] = []
    
    // Create a View Model to interact with the API
    @StateObject var model = RecipeSearchViewModel()
    
    // Access the pantry environment object
    @EnvironmentObject var pantry: Pantry
    
    // Required so that this view can be 'dismissed' with a closure
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        // Wrap everything in a NavigationView so that pages can easily be navigated between
        NavigationView{
            VStack {
                HStack {
                    Button(action: {
                        // Grabs recipes from the Spoonacular API through the ViewModel
                        model.findRecipes(inputs: pantry.ingredients)
                        recipes.removeAll()
                        for index in 0..<(model.model.count) {
                            recipes.append(model.model[index].title ?? "Placeholder Recipe Title")
                        }
                    }, label: {
                        Text("API Call Test")
                    })
                    
                    Button(action: {
                        // Dismiss this current view and return to the previous one
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "note").foregroundColor(.black)
                    })
                }
                
                Spacer()
                
                ScrollView {
                    ForEach(0 ..< model.model.count, id: \.self) { i in
                        
                        if (checkForOneSquare(loop: i, count: model.model.count)) {
                            ZStack {
                                Rectangle().aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                Text(model.model[i].title ?? "Placeholder").foregroundColor(.orange)
                            }
                        }
                        
                        else {
                            if (checkForTwoSquares(loop: i)) {
                                HStack {
                                    ZStack {
                                        Rectangle().aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                        Text(model.model[i-1].title ?? "Placeholder").foregroundColor(.orange)
                                    }
                                    ZStack {
                                        Rectangle().aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                        Text(model.model[i].title ?? "Placeholder").foregroundColor(.orange)
                                    }
                                }
                            } else {
                                /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
                            }
                        }
                    }
                }
                                
                Spacer()
                
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

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
