//
//  Tastepedia.swift
//  Shared
//
//  Created by CSStudent on 2/14/22.
//
// The application's main file

import SwiftUI

// Starting point for the application
// Calls the MainView() as the beginning view
@main
struct Tastepedia: App {
    // Create an instance of the Pantry class to keep track of ingredients
    @StateObject var pantry = Pantry()
    
    // Create an instance of the Cookbook class to keep track of saved recipes
    @StateObject var cookbook = Cookbook()
    
    // Create an instance of the IngredientsFile class to open up the txt file of ingredients and use them later
    @StateObject var ingredientsList = IngredientsFile()
    
    // Start the application in a given view
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(pantry).environmentObject(cookbook).environmentObject(ingredientsList)
        }
    }
}

struct Recipe: Equatable, Codable {
    let id: Int
    let name: String
    let ingredients: IngredientsInformation
    var instructions: InstructionSearchElement
    
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return (lhs.id == rhs.id)
    }
}

class ObservableRecipe: ObservableObject {
    let id: Int
    let name: String
    let ingredients: IngredientsInformation
    @Published var instructions: InstructionSearchElement
    
    init(_ id: Int, _ name: String, _ ingredients: IngredientsInformation, _ instructions: InstructionSearchElement) {
        self.id = id
        self.name = name
        self.ingredients = ingredients
        self.instructions = instructions
    }
    
    func getInstructions(){
        if (self.instructions.steps![0].step == "Loading Recipe Instructions...") {
            self.grabInstructions(id: self.id, completion: {
                // Put code in here that you want to run when the grabInstructions() function hits completed()
            })
            return
        }
        else {
            return
        }
    }
    
    func grabInstructions(id: Int, completion: @escaping () -> () = {}){
        self.instructions = [InstructionSearchElement(name: "", steps: [Step(number: 1, step: "Loading Recipe Instructions...")])][0]
        
        // Create custom URL with desired recipe ID from id parameter
        let url: URL! = URL(string: "https://api.spoonacular.com/recipes/" + String(id) + "/analyzedInstructions?apiKey=af2da9210db04a9d8bb691d2f4166632")
        print("Grabbing Instructions from: \(url.absoluteString)")
        
        let request = URLRequest(url: url)
        
        // Make the API call
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if data == nil {
                    print("No data recieved.")
                    completion()
                    return
                }
                do {
                    let result = try JSONDecoder().decode([InstructionSearchElement].self, from: data!)
                    if result.isEmpty {
                        print("Instruction model is empty.")
                        self.instructions = InstructionSearchElement(name: "", steps: [Step(number: 1, step: "No Instructions Found")])
                    } else {
                        self.instructions = result[0]
                    }
                    print("Successfully decoded JSON")
                    completion()
                } catch {
                    print("Trouble decoding JSON. Error below.")
                    print("Error: \(error)")
                    completion()
                }
            }
        }
        session.resume()
    }
}

// The Pantry class that verifies the existence of 'savedIngredients' in UserDefaults
// Also has the ability to add/remove ingredients to/from local storage
class Pantry: ObservableObject {
    @Published var ingredients: [String] // Stores all the user's current ingredients in an array
    
    // Verifies that the device has the ingredients in local storage
    init() {
        if UserDefaults.standard.object(forKey: "savedIngredients") == nil {
            UserDefaults.standard.setValue([], forKey: "savedIngredients")
        }
        ingredients = UserDefaults.standard.object(forKey: "savedIngredients") as? [String] ?? [String]()
    }
    
    // Adds an ingredient to local and application storage
    func addIngredient(_ ingredientToAdd: String){
        ingredients.append(ingredientToAdd)
        ingredients.sort()
        UserDefaults.standard.set(ingredients, forKey: "savedIngredients")
    }
    
    // Removes an ingredient from local and applications storage
    func removeIngredient(_ ingredientToRemove: String){
        ingredients.remove(at: ingredients.firstIndex(where: {$0 == ingredientToRemove}) ?? 0)
        ingredients.sort()
        UserDefaults.standard.set(ingredients, forKey: "savedIngredients")
    }
}

class Cookbook: ObservableObject {
    @Published var savedRecipes: [Recipe]
    
    init() {
        print("Initializing Cookbook")
        if UserDefaults.standard.data(forKey: "savedRecipes") == nil{
            print("Creating Cookbook in Local Storage")
            do {
                // Create an empty array of recipes to initialize the UserDefaults storage for future use
                
                // Create JSON Encoder
                let encoder = JSONEncoder()
                
                // Encode Note
                let data = try encoder.encode([Recipe]())
                
                // Write/Set Data
                UserDefaults.standard.set(data, forKey: "savedRecipes")
                
            } catch {
                print("Unable to Encode Array of Recipes (\(error))")
            }
        }
        // Read/Get Data
        do {
            // Create JSON Decoder
            let decoder = JSONDecoder()
            
            // Decode Note
            savedRecipes = try decoder.decode([Recipe].self, from: UserDefaults.standard.data(forKey: "savedRecipes")!)
            
        } catch {
            print("Unable to Decode Recipes (\(error))")
            savedRecipes = []
        }
        
        print("Finished Cookbook initialization")
    }
    
    // Adds a recipe to local and application storage
    func addReipe(_ recipeToAdd: Recipe){
        savedRecipes.append(recipeToAdd)
        print("Saved Recipe to Cookbook")
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()
            
            // Encode Note
            let data = try encoder.encode(savedRecipes)
            
            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "savedRecipes")
            print("Saved Cookbook to local storage")
            
        } catch {
            print("Unable to Encode Array of Recipes (\(error))")
        }
    }
    
    // Removes recipe from local and application storage
    func removeRecipe(_ recipeToRemove: Int){
        savedRecipes.remove(at: savedRecipes.firstIndex(where: {$0.id == recipeToRemove}) ?? 0)
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()
            
            // Encode Note
            let data = try encoder.encode(savedRecipes)
            
            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "savedRecipes")
            
        } catch {
            print("Unable to Encode Array of Recipes (\(error))")
        }
    }
    
}

// Grabs Master Ingredients List from external txt file and compiles them into an array
class IngredientsFile: ObservableObject {
    var ingredientsList: [String] = [] // Keeps all ingredients available for the user to interact with in an easily accessible array
    
    // Loads the ingredients list from a text file
    init() {
        if let fileURL = Bundle.main.url(forResource: "MasterIngredientsList", withExtension: "txt") {
            if let fileContents = try? String(contentsOf: fileURL) {
                print("Loaded ingredients file from bundle.")
                for line in fileContents.split(separator: "\r\n") {
                    ingredientsList.append(String(line))
                }
            } else {
                print("Error loading ingredients file.")
            }
        }
    }
    
    func getDocumentDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

// To keep track of a specific recipe's ingredients and their amounts
class IngredientsInformation: ObservableObject, Equatable, Codable {
    var names: [String]
    var amounts: [String]
    var units: [String]
    
    // Adds to the IngredientsInformation object ingredients, both missed and used, from the Recipe Search Element object passed as a parameter
    init(recipe: RecipeSearchElement) {
        var index = 0
        var temp = [SedIngredient]()
        for ingredient in recipe.usedIngredients! {
            temp.append(ingredient)
        }
        for ingredient in recipe.missedIngredients! {
            temp.append(ingredient)
        }
        names = [String](repeating: "nil", count: temp.count)
        amounts = [String](repeating: "nil", count: temp.count)
        units = [String](repeating: "nil", count: temp.count)
        for ingredient in temp {
            self.names[index] = ingredient.name!
            self.amounts[index] = String(format: "%.2f", ingredient.amount!)
            self.units[index] = ingredient.unitLong!
            index += 1
        }
    }
    
    static func == (lhs: IngredientsInformation, rhs: IngredientsInformation) -> Bool {
        return (lhs.names == rhs.names && lhs.amounts == rhs.amounts && lhs.units == rhs.units)
    }
}

// Checks if there needs to be one big square for an odd number of ingredients in the pantry
// Using this function to minimize indexing time instead of doing this all in-line
func oneSquare(loop: Int, count: Int) -> Bool {
    let first: Bool = ((count - loop) == 1);
    let second: Bool = ((count % 2) == 1);
    let final: Bool = (first && second);
    return final;
}

// Checks if there needs to be two smaller squares for an even number of ingredients in the pantry
// Using this function to minimize indexing time instead of doing this all in-line
func twoSquares(loop: Int) -> Bool {
    return (loop % 2 == 1)
}

// MARK: - Helper functions for creating encoders and decoders
// Creates and returns an instance of Apple's JSONDecoder class
func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

// Creates and returns an instance of Apple's JSONEncoder class
func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
