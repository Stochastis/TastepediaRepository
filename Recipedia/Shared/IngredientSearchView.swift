//
//  IngredientSearchView.swift
//  Recipedia (iOS)
//
//  Created by Caleb Ross on 3/19/22.
//

import SwiftUI

struct IngredientSearchView: View {
    
    // Required so that this view can be 'dismissed' with a closure
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            HStack {
                Button(action: {
                    // Dismiss this current view and return to the previous one
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "note").foregroundColor(.black)
                })
                Text("This is the Ingredient Search View.")
            }
        }.navigationBarHidden(true)
    }
}

struct IngredientSearchView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientSearchView()
    }
}
