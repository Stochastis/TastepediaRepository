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
                        
                        if (oneSquare(loop: i, count: model.model.count)) {
                            ZStack {
                                Rectangle().aspectRatio(1, contentMode: .fill)
                                Text(model.model[i].title ?? "Placeholder").foregroundColor(.orange)
                            }
                        }
                        
                        else {
                            if (twoSquares(loop: i)) {
                                HStack {
                                    ZStack {
                                        Rectangle().aspectRatio(1, contentMode: .fill)
                                        Text(model.model[i-1].title ?? "Placeholder").foregroundColor(.orange)
                                    }
                                    ZStack {
                                        Rectangle().aspectRatio(1, contentMode: .fill)
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

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
