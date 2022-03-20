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
    
    @StateObject var ingredientsList = topIngredients()
    
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
                    Text("This is the Ingredient Search View.")
                }
                Button(action: {
                    print("Button pressed")
                }, label: {
                    Text("Button")
                })
            }
        }.navigationBarHidden(true)
    }
}

class topIngredients: ObservableObject {
    var ingredients: [String] = []
    
    init() {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Top1kIngredients.txt")

        do {
            let todos = try String(contentsOf: path)

            for todo in todos.split(separator: "\n") {
                print(todo)
            }
        } catch {
            print(error.localizedDescription)
        }
        print(path.absoluteString)
        print(getDocumentDirectory())
    }
    
    func getDocumentDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

struct IngredientSearchView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientSearchView()
    }
}
