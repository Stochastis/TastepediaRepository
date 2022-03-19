//
//  ContentView.swift
//  Shared
//
//  Created by Caleb Ross on 2/14/22.
//

import SwiftUI

struct MainView: View {
    
    // Temporary array for ingredient buttons. Delete or change this.
    @State var buttonIngredients: [[String]] = [["onions", "butter", "pepper"], ["tomatoes", "peppers", "asparagus"], ["squash", "chicken", "lamb"], ["beef", "cucumbers", "strawberries"], ["watermelon", "sugar", "blueberries"]]
    
    // Access the pantry environment object
    @EnvironmentObject var pantry: Pantry
    
    var body: some View {
        
        // Wrap everything in a NavigationView so that pages can easily be navigated between
        NavigationView {
            ZStack {
                VStack {
                    Spacer()
                    HStack() {
                        
                        // Essentially a button that uses the functionality of NavigationView to go between different views
                        NavigationLink(
                            destination: SearchView(),
                            label: {
                                Image(systemName: "magnifyingglass")
                            })
                        
                        ForEach(0 ..< 5) { i in
                            VStack {
                                ForEach(0 ..< 3) { j in
                                    Button(action: {
                                        pantry.ingredients.append(buttonIngredients[i][j])
                                        print(pantry.ingredients)
                                    }, label: {
                                        RoundedRectangle(cornerRadius: 10).frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(.white)
                                            .overlay(Image("ChickenIcon").resizable())
                                    })
                                    .padding(.bottom, 1.0)
                                }
                            }
                        }
                        
                        // Essentially a button that uses the functionality of NavigationView to go between different views
                        NavigationLink(
                            destination: PantryView(pantry: pantry),
                            label: {
                                Image(systemName: "tray.2.fill")
                            })
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background(Color.orange)
                .ignoresSafeArea()
                
                // Investigate why this Text View is by itself in an HStack
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
                    Spacer()
                    Spacer()
                }
            }
        }.navigationBarHidden(true)
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(Pantry(startingIngredients: ["Salt", "Garlic", "Peppers", "Avacado", "Beef"]))
        
        
    }
}
