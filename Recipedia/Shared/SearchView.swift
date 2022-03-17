//
//  SearchView.swift
//  Recipedia (iOS)
//
//  Created by Caleb Ross on 3/17/22.
//

import SwiftUI

struct SearchView: View {
    
    // Required so that this view can be 'dismissed' with a closure
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        
        // Wrap everything in a NavigationView so that pages can easily be navigated between
        NavigationView{
            HStack {
                Text("This is the SearchView.")
                Button(action: {
                    // Dismiss this current view and return to the previous one
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "note")
                })
            }
        }.navigationBarHidden(true)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
