//
//  InstructionSearchViewModel.swift
//  Tastepedia (iOS)
//
//  Created by Caleb Ross on 4/3/22.
//
// This is a View Model that mediates interactions between the view and the model that directly interacts with the API

import Foundation

class InstructionSearchViewModel: ObservableObject {
    
    @Published var instructions = [InstructionSearchElement]()
    
    init () {
        instructions = [InstructionSearchElement(name: "", steps: [Step(number: 1, step: "Loading Recipe Instructions...")])]
    }
    
    func findInstructions(id: Int) {
        
        // Create custom URL with desired recipe ID from id parameter
        let url: URL! = URL(string: "https://api.spoonacular.com/recipes/" + String(id) + "/analyzedInstructions?apiKey=af2da9210db04a9d8bb691d2f4166632")
        print(url.absoluteString)
        
        let request = URLRequest(url: url)
        
        // Make the API call
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if data == nil {
                    print("No data recieved.")
                }
                do {
                    self.instructions = try JSONDecoder().decode([InstructionSearchElement].self, from: data!)
                    print("Successfully decoded JSON")
                } catch {
                    print("Trouble decoding JSON. Error below.")
                    print("Error: \(error)")
                }
                if self.instructions.isEmpty {
                    print("Instruction model is empty.")
                    self.instructions.append(InstructionSearchElement(name: "", steps: [Step(number: 1, step: "No Instructions Found")]))
                }
            }
        }
        session.resume()
    }
}
