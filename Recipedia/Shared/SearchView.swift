//
//  SearchView.swift
//  Recipedia (iOS)
//
//  Created by Caleb Ross on 3/17/22.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        NavigationView{
            HStack {
                Text("This is the SearchView.")
                NavigationLink(
                    destination: MainView(),
                    label: {
                        Image(systemName: "note")
                    })
            }
        }.navigationBarHidden(true)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
