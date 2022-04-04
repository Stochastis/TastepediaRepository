//
//  RecipeDetailsView.swift
//  Tastepedia (iOS)
//
//  Created by Caleb Ross on 4/1/22.
//

import SwiftUI

struct RecipeDetailsView: View {
    
    // Create a View Model to interact with the API
    @StateObject var model: InstructionSearchViewModel
    
    var body: some View {
        ScrollView {
            ForEach(0 ..< model.instructions[0].steps!.count, id: \.self) { i in
                VStack {
                    Text("Step \(i+1):")
                    Text(model.instructions[0].steps![i].step!)
                        .padding(/*@START_MENU_TOKEN@*/[.leading, .bottom, .trailing]/*@END_MENU_TOKEN@*/)
                }
            }
        }
    }
}

struct RecipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailsView(model: InstructionSearchViewModel())
    }
}
