//
//  ContentView.swift
//  Shared
//
//  Created by Caleb Ross on 2/14/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.orange.edgesIgnoringSafeArea(.all)
            RoundedRectangle(cornerRadius: 10).frame(width: 50, height: 50).foregroundColor(.white)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
        
    }
}
