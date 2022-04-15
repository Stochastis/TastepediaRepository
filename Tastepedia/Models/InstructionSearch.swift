//////
//////  InstructionSearch.swift
//////  Tastepedia (iOS)
//////
//////  Created by Caleb Ross on 4/3/22.
//////
//////  This is the model that directly interacts with the API directly as well as the Instruction Search View Model

import Foundation

// MARK: - InstructionSearchElement
struct InstructionSearchElement: Codable, Equatable {
    var name: String?
    var steps: [Step]? // Includes information such as the directions themselves, the equipment/ingredients needed, and the time it will take for this a particular step
    
    static func == (lhs: InstructionSearchElement, rhs: InstructionSearchElement) -> Bool {
        return (lhs.name == rhs.name && lhs.steps == rhs.steps)
    }
}

// MARK: InstructionSearchElement convenience initializers and mutators
// Adds functionality to the InstructionSearchElement class
extension InstructionSearchElement {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(InstructionSearchElement.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        name: String?? = nil,
        steps: [Step]?? = nil
    ) -> InstructionSearchElement {
        return InstructionSearchElement(
            name: name ?? self.name,
            steps: steps ?? self.steps
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// An object that stores information about a single step in a recipe's instructions.
// Information includes the step's number, the directions themselves, the ingredients/equipment needed, and how long it will take to complete.
struct Step: Codable, Equatable {
    var number: Int?
    var step: String?
    var ingredients, equipment: [Ent]?
    var length: Length?
    
    static func == (lhs: Step, rhs: Step) -> Bool {
        return (lhs.number == rhs.number && lhs.step == rhs.step && lhs.ingredients == rhs.ingredients && lhs.equipment == rhs.equipment && lhs.length == rhs.length)
    }
}

// MARK: Step convenience initializers and mutators
// Adds functionality to the Step class
extension Step {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Step.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        number: Int?? = nil,
        step: String?? = nil,
        ingredients: [Ent]?? = nil,
        equipment: [Ent]?? = nil,
        length: Length?? = nil
    ) -> Step {
        return Step(
            number: number ?? self.number,
            step: step ?? self.step,
            ingredients: ingredients ?? self.ingredients,
            equipment: equipment ?? self.equipment,
            length: length ?? self.length
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// An object that stores information about either an ingredient or a piece of equipment
struct Ent: Codable, Equatable {
    var id: Int?
    var name, localizedName, image: String?
}

// MARK: Ent convenience initializers and mutators
// Adds functionality to the Ent class
extension Ent {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Ent.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        id: Int?? = nil,
        name: String?? = nil,
        localizedName: String?? = nil,
        image: String?? = nil
    ) -> Ent {
        return Ent(
            id: id ?? self.id,
            name: name ?? self.name,
            localizedName: localizedName ?? self.localizedName,
            image: image ?? self.image
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Length
struct Length: Codable, Equatable {
    var number: Int?
    var unit: String?
}

// MARK: Length convenience initializers and mutators
// Adds functionality to the Length class
extension Length {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Length.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        number: Int?? = nil,
        unit: String?? = nil
    ) -> Length {
        return Length(
            number: number ?? self.number,
            unit: unit ?? self.unit
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

typealias InstructionSearch = [InstructionSearchElement]

// Adds functionality to Arrays of InstructionSearch objects
extension Array where Element == InstructionSearch.Element {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(InstructionSearch.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - URLSession response handlers
// Adds functionality to the URLSession class
extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    
    func instructionSearchTask(with url: URL, completionHandler: @escaping (InstructionSearch?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
