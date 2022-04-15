//
//  CookbookView.swift
//  Tastepedia (iOS)
//
//  Created by Caleb Ross on 4/14/22.
//

import SwiftUI

struct CookbookView: View {
    // Access the cookbook environment object
    @EnvironmentObject var cookbook: Cookbook
    
    var body: some View {
        Text(cookbook.savedRecipes[0].name)
    }
}

struct CookbookView_Previews: PreviewProvider {
    static var previews: some View {
        CookbookView()
    }
}
