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
                                Image(systemName: "magnifyingglass").foregroundColor(.black)
                            })
                        Spacer()
                        NavigationLink(
                            destination: CookbookView(),
                            label: {
                                Image(systemName: "text.book.closed").foregroundColor(.black)
                            }).offset(x: 0, y: -100)
                        Spacer()
                        // Essentially a button that uses the functionality of NavigationView to go between different views
                        NavigationLink(
                            destination: PantryView(),
                            label: {
                                Image(systemName: "tray.2.fill").foregroundColor(.black)
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
