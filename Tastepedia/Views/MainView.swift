//
//  MainView.swift
//  Shared
//
//  Created by Caleb Ross on 2/14/22.
//
//  This is the main page

import SwiftUI

struct MainView: View {
    
    var body: some View {
        
        // Wrap everything in a NavigationView so that pages can easily be navigated between
        NavigationView {
            ZStack {
                VStack {
                    Spacer()
                    HStack() {
                        Spacer()
                        // Essentially a button that uses the functionality of NavigationView to go between different views
                        NavigationLink(
                            destination: RecipeSearchView(),
                            label: {
                                VStack {
                                    Image(systemName: "magnifyingglass").resizable().frame(width: 32.0, height: 32.0).foregroundColor(.black)
                                    Text("Search").foregroundColor(.black)
                                }
                            })
                        Spacer()
                        NavigationLink(
                            destination: CookbookView(),
                            label: {
                                VStack {
                                    Image(systemName: "text.book.closed").resizable().frame(width: 32.0, height: 40.0).foregroundColor(.black).foregroundColor(.black)
                                    Text("Cookbook").foregroundColor(.black)
                                }
                            }).offset(x: 0, y: -100)
                        Spacer()
                        // Essentially a button that uses the functionality of NavigationView to go between different views
                        NavigationLink(
                            destination: PantryView(),
                            label: {
                                VStack {
                                    Image(systemName: "tray.2.fill").resizable().frame(width: 32.0, height: 32.0).foregroundColor(.black).foregroundColor(.black)
                                    Text("Pantry").foregroundColor(.black)
                                }
                            })
                        Spacer()
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background(Color.orange)
                .ignoresSafeArea()
            }
        }.navigationBarHidden(true)
    }
}
