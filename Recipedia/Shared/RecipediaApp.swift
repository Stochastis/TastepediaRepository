//
//  RecipediaApp.swift
//  Shared
//
//  Created by CSStudent on 2/14/22.
//

import SwiftUI

var currentView = "MainView"

@main
struct RecipediaApp: App {
    var body: some Scene {
        WindowGroup {
            if currentView == "MainView" {
                MainView()
            }
            else if currentView == "PantryView" {
                PantryView()
            }
        }
    }
}

