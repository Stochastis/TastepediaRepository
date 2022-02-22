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
                Button(action: {
                    print("Button 1 Pressed")
                }) {
                    Text("1")
                        .frame(width: 50, height: 50)
                        .font(.system(size: 18))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        )
                }
                .padding(.bottom, 1.0)
                Button(action: {
                    print("Button 2 Pressed")
                }) {
                    Text("2")
                        .frame(width: 50, height: 50)
                        .font(.system(size: 18))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        )
                }
                .padding(.bottom, 1.0)
                Button(action: {
                    print("Button 3 Pressed")
                }) {
                    Text("3")
                        .frame(width: 50, height: 50)
                        .font(.system(size: 18))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        )
                }
                .padding(.bottom, 1.0)
            }
            VStack {
                Button(action: {
                    print("Button 4 Pressed")
                }) {
                    Text("4")
                        .frame(width: 50, height: 50)
                        .font(.system(size: 18))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        )
                }
                .padding(.bottom, 1.0)
                Button(action: {
                    print("Button 5 Pressed")
                }) {
                    Text("5")
                        .frame(width: 50, height: 50)
                        .font(.system(size: 18))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        )
                }
                .padding(.bottom, 1.0)
                Button(action: {
                    print("Button 6 Pressed")
                }) {
                    Text("6")
                        .frame(width: 50, height: 50)
                        .font(.system(size: 18))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        )
                }
                .padding(.bottom, 1.0)
            }
            VStack {
                Button(action: {
                    print("Button 7 Pressed")
                }) {
                    Text("7")
                        .frame(width: 50, height: 50)
                        .font(.system(size: 18))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        )
                }
                .padding(.bottom, 1.0)
                Button(action: {
                    print("Button 8 Pressed")
                }) {
                    Text("8")
                        .frame(width: 50, height: 50)
                        .font(.system(size: 18))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        )
                }
                .padding(.bottom, 1.0)
                Button(action: {
                    print("Button 9 Pressed")
                }) {
                    Text("9")
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
