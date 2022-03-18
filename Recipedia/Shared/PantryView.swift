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
    
    // Create ObservedObject for list of ingredients in pantry
    @ObservedObject var pantry: Pantry
    
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
                    ForEach(0 ..< pantry.ingredients.count) { i in
                        if ((pantry.ingredients.count - i) == 1 && pantry.ingredients.count % 2 == 1) {
                            ZStack {
                                Rectangle().aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                Text("\(pantry.ingredients[i])").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            }
                        } else {
                            if (calculate(loop: i)) {
                                HStack {
                                    ZStack {
                                        Rectangle().aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                        Text("\(pantry.ingredients[i-1])").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                    }
                                    ZStack {
                                        Rectangle().aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                        Text("\(pantry.ingredients[i])").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                    }
                                }
                            } else {
                                /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
                            }
                        }
                    }
                }
            }
        }.navigationBarHidden(true)
    }
}

func calculate(loop: Int) -> Bool {
    return (loop % 2 == 1)
}

struct PantryView_Previews: PreviewProvider {
    static var previews: some View {
        PantryView(pantry: Pantry(startingIngredients: ["Salt", "Garlic", "Peppers", "Avacado", "Beef"]))
    }
}
