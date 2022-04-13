//
//  IngredientSearchView.swift
//  Tastepedia (iOS)
//
//  Created by Caleb Ross on 3/19/22.
//
//  A view that allows users to search for and add ingredients to their pantry

import SwiftUI

struct IngredientSearchView: View {
    // A variable for keeping track of the phone's current color scheme
    @Environment(\.colorScheme) var colorScheme
    
    
    // Required so that this view can be 'dismissed' with a closure
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var searchQuery = ""
    
    @State var filteredIngredients: [String] = []
    
    @EnvironmentObject var ingredientsFile: IngredientsFile
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass").foregroundColor(.black)
                TextField("Enter an ingredient...", text: $searchQuery).onChange(of: searchQuery) { newValue in
                    print("Query changed to \"\(searchQuery)\".")
                    filteredIngredients = ingredientsFile.ingredientsList.filter({$0.localizedCaseInsensitiveContains(searchQuery)})
                }
            }.padding(.vertical, 10).padding(.horizontal).background(Color.primary.opacity(colorScheme == .dark ? 0.5 : 0.05)).cornerRadius(8).padding(.horizontal)
            
            Spacer()
            
            IngredientSearchScrollView(filteredIngredients: $filteredIngredients)
        }.navigationTitle("Ingredient Search")
    }
}

struct IngredientSearchView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientSearchView()
    }
}
