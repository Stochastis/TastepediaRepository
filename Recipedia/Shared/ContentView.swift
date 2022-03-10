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
    @State private var flag = false
    
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
                    model.findRecipes(inputs: ["potatoes", "onions"])
                    recipes.removeAll()
                    for index in 0..<(model.model.count) {
                        recipes.append(model.model[index].title ?? "Placeholder Recipe Title")
                    }
                    if !recipes.isEmpty {
                        currentSearchResult = recipes.randomElement() ?? ""
                        self.flag.toggle()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
        
    }
}
