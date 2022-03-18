//
//  PantryView.swift
//  Recipedia (iOS)
//
//  Created by Caleb Ross on 3/17/22.
//

import SwiftUI

struct PantryView: View {
    
    // Required so that this view can be 'dismissed' with a closure
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        
        // Wrap everything in a NavigationView so that pages can easily be navigated between
        NavigationView{
            VStack {
                HStack {
                    Button(action: {
                        // Dismiss this current view and return to the previous one
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "note")
                    })
                    Text("This is the PantryView.")
                }
                Spacer()
                ScrollView {
                    ForEach(1 ..< 51) { i in
                        HStack {
                            ZStack {
                                Rectangle().aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                Text("Item \(i*2-1)").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            }
                            ZStack {
                                Rectangle().aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                Text("Item \(i*2)").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            }
                        }
                    }
                }
            }
        }.navigationBarHidden(true)
    }
}

struct PantryView_Previews: PreviewProvider {
    static var previews: some View {
        PantryView()
    }
}
