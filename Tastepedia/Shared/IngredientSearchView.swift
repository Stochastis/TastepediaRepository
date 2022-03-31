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
    
    @State var searchQuery = ""
    
    @State var filteredIngredients: [String] = []
    
    @EnvironmentObject var ingredientsFile: IngredientsFile
                
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    // Return Button
                    Button(action: {
                        // Dismiss this current view and return to the previous one
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "note").foregroundColor(.black)
                    })
                    
                    HStack {
                        Image(systemName: "magnifyingglass").foregroundColor(.black)
                        TextField("Enter an ingredient...", text: $searchQuery).onChange(of: searchQuery) { newValue in
                            print("Query changed to \"\(searchQuery)\".")
                            filteredIngredients = ingredientsFile.ingredientsList.filter({$0.localizedCaseInsensitiveContains(searchQuery)})
                        }
                    }.padding(.vertical, 10).padding(.horizontal).background(Color.primary.opacity(0.05)).cornerRadius(8).padding(.horizontal)
                }
                
                Spacer()
                
                IngredientSearchScrollView(filteredIngredients: $filteredIngredients)
            }
        }.navigationBarHidden(true)
    }
}

struct IngredientSearchView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientSearchView()
    }
}
