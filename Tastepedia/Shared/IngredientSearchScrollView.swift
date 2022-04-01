//
//  IngredientSearchScrollView.swift
//  Tastepedia (iOS)
//
//  Created by Caleb Ross on 3/24/22.
//

import SwiftUI

struct IngredientSearchScrollView: View {
    @EnvironmentObject var ingredientsList: IngredientsFile
    
    @Binding var filteredIngredients: [String]
    
    var body: some View {
        ScrollView {
            if (filteredIngredients.count != 0) {
                // If there is an even number of results
                if (filteredIngredients.count % 2 == 0) {
                    ForEach((0 ..< filteredIngredients.count), id: \.self) { i in
                        if (i % 2 == 0) {
                            HStack{
                                PISquareView(textsToShow: $filteredIngredients, index: i, width: 150, height: 150)
                                PISquareView(textsToShow: $filteredIngredients, index: i+1, width: 150, height: 150)
                            }
                        }
                    }
                }
                // If there is an odd number of results
                else {
                    ForEach((0 ..< filteredIngredients.count), id: \.self) { i in
                        if (i != (filteredIngredients.count - 1)) {
                            if (i % 2 == 0) {
                                HStack{
                                    PISquareView(textsToShow: $filteredIngredients, index: i, width: 150, height: 150)
                                    PISquareView(textsToShow: $filteredIngredients, index: i+1, width: 150, height: 150)
                                }
                            }
                        }
                        else {
                            PISquareView(textsToShow: $filteredIngredients, index: i, width: 300, height: 300)
                        }
                    }
                }
            }
            else {
                EmptyView()
            }
        }
    }
}
