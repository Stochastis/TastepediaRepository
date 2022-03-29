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
    
    @EnvironmentObject var ingredientsList: IngredientsFile
    
    @EnvironmentObject var pantry: Pantry
    
    // For easier access to UserDefaults
    let storedData = UserDefaults.standard
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        // Dismiss this current view and return to the previous one
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "note").foregroundColor(.black)
                    })
                    
                    HStack {
                        Image(systemName: "magnifyingglass").foregroundColor(.black)
                        TextField("Enter an ingredient...", text: $searchQuery)
                    }.padding(.vertical, 10).padding(.horizontal).background(Color.primary.opacity(0.05)).cornerRadius(8).padding(.horizontal)
                }
                Spacer()
                IngredientSearchScrollView(searchQuery: $searchQuery)
            }
        }.navigationBarHidden(true)
    }
}

struct IngredientSearchView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientSearchView().environmentObject(IngredientsFile())
    }
}
