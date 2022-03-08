//
//  ContentView.swift
//  Shared
//
//  Created by Caleb Ross on 2/14/22.
//

import SwiftUI

struct ContentView: View {
    
    var foodIconNames: Array = ["drop", "hare", "tortoise", "ant", "ladybug", "leaf"]
    @StateObject var model = RecipeSearchViewModel() // Create a View Model to interact with the API
    @State var currentSearchResult: String = "Search Result Goes Here"
    @State var recipes: [String] = []
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack() {
                    ForEach(0 ..< 5) { i in
                        VStack {
                            ForEach(0 ..< 3) { j in
                                Button(action: {
                                    print(String(i) + ", " + String(j))
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
                    model.findRecipes(inputs: ["eggs", "tortillas", "fish"])
                    for index in 0..<(model.model.count) {
                        recipes.append(model.model[index].title ?? "Placeholder Recipe Title")
                    }
                    print(recipes)
                    currentSearchResult = recipes[0]
                }, label: {
                    Text("API Call Test")
                })
                Spacer()
                Text(currentSearchResult)
                Spacer()
            }
        }
        // Must run findRecipes() on appearing because it doesn't work if only running when clicking the button
        .onAppear() {
            model.findRecipes(inputs: ["corn", "driedtomatoes", "cucumber"])
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
        
    }
}
