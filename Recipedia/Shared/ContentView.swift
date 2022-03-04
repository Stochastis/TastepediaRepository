//
//  ContentView.swift
//  Shared
//
//  Created by Caleb Ross on 2/14/22.
//

import SwiftUI

struct ContentView: View {
    
    var foodIconNames: Array = ["drop", "hare", "tortoise", "ant", "ladybug", "leaf"]
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack() {
                    ForEach(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { i in
                        VStack {
                            ForEach(0 ..< 3) { j in
                                Button(action: {
                                    print(String(i) + ", " + String(j))
                                }, label: {
                                    RoundedRectangle(cornerRadius: 10).frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(.white)
                                        .overlay(Image("ChickenIcon").resizable())
                                })
                                .padding(.bottom, 1.0)
                            }
                        }
                    }
                }
                Spacer()
                Button(action: {
                    print("DEBUG")
                }, label: {
                    Text("API Call Test")
                })
                Spacer()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(Color.orange)
            .ignoresSafeArea()
            
            HStack {
                Text("Enter some ingredients:")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
        
    }
}
