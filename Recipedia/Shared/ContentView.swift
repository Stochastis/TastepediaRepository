//
//  ContentView.swift
//  Shared
//
//  Created by Caleb Ross on 2/14/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack() {
            VStack {
                RoundedRectangle(cornerRadius: 10).frame(width: 50, height: 50).foregroundColor(.white)
                RoundedRectangle(cornerRadius: 10).frame(width: 50, height: 50).foregroundColor(.white)
                RoundedRectangle(cornerRadius: 10).frame(width: 50, height: 50).foregroundColor(.white)
            }
            VStack {
                RoundedRectangle(cornerRadius: 10).frame(width: 50, height: 50).foregroundColor(.white)
                RoundedRectangle(cornerRadius: 10).frame(width: 50, height: 50).foregroundColor(.white)
                RoundedRectangle(cornerRadius: 10).frame(width: 50, height: 50).foregroundColor(.white)
            }
            VStack {
                RoundedRectangle(cornerRadius: 10).frame(width: 50, height: 50).foregroundColor(.white)
                RoundedRectangle(cornerRadius: 10).frame(width: 50, height: 50).foregroundColor(.white)
                RoundedRectangle(cornerRadius: 10).frame(width: 50, height: 50).foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.orange/*@END_MENU_TOKEN@*/)
        .ignoresSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
        
    }
}
