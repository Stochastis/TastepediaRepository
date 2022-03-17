//
//  PantryView.swift
//  Recipedia (iOS)
//
//  Created by Caleb Ross on 3/17/22.
//

import SwiftUI

struct PantryView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationView{
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "note")
                })
                Text("This is the PantryView.")
            }
        }.navigationBarHidden(true)
    }
}

struct PantryView_Previews: PreviewProvider {
    static var previews: some View {
        PantryView()
    }
}
