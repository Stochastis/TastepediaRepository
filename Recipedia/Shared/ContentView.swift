//
//  ContentView.swift
//  Shared
//
//  Created by Caleb Ross on 2/14/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
                                        
            Text("Enter some ingredients.")
                .alignmentGuide(.top) {dimension in
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/dimension[.top]/*@END_MENU_TOKEN@*/
                }
            
            HStack() {
                ForEach(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                    VStack {
                        ForEach(0 ..< 3) { item in
                            Button(action: {
                                print("Button 1 Pressed")
                            }) {
                                Text("Woa")
                                    .frame(width: 50, height: 50)
                                    .font(.system(size: 18))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                                    )
                            }
                            .padding(.bottom, 1.0)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.orange/*@END_MENU_TOKEN@*/)
        .ignoresSafeArea()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
        
    }
}
