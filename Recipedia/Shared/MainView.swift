//
//  ContentView.swift
//  Shared
//
//  Created by Caleb Ross on 2/14/22.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var model = RecipeSearchViewModel() // Create a View Model to interact with the API
    @State var recipes: [String] = []
    @State var ingredients: [String] = []
    @State var buttonIngredients: [[String]] = [["onions", "butter", "pepper"], ["tomatoes", "peppers", "asparagus"], ["squash", "chicken", "lamb"], ["beef", "cucumbers", "strawberries"], ["watermelon", "sugar", "blueberries"]]
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack() {
                    ForEach(0 ..< 5) { i in
                        VStack {
                            ForEach(0 ..< 3) { j in
                                Button(action: {
                                    ingredients.append(buttonIngredients[i][j])
                                    print(ingredients)
                                }, label: {
                                    RoundedRectangle(cornerRadius: 10).frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(.white)
                                        .overlay(Image("ChickenIcon").resizable())
                                })
                                .padding(.bottom, 1.0)
                            }
                        }
                    }
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(Color.orange)
            .ignoresSafeArea()
            
            HStack {
                Text("Enter some ingredients:")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
            VStack {
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Button(action: {
                    model.findRecipes(inputs: ["ginger", "cilantro", "redbellpeppers"])
                    recipes.removeAll()
                    for index in 0..<(model.model.count) {
                        recipes.append(model.model[index].title ?? "Placeholder Recipe Title")
                    }
                }, label: {
                    Text("API Call Test")
                })
                Spacer()
                Text(!model.model.isEmpty ? String(model.model.randomElement()?.title ?? "") : "")
                Spacer()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
        
        
    }
}
