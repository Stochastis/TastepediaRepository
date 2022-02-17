//
//  ContentView.swift
//  Shared
//
//  Created by CSStudent on 2/14/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
                Color.orange.edgesIgnoringSafeArea(.all)
                Text("Hello, world!").padding()
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
            
    }
}
