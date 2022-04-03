//
//  InstructionSearch.swift
//  Tastepedia (iOS)
//
//  Created by Caleb Ross on 4/3/22.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let instructionSearch = try InstructionSearch(json)

import Foundation

// MARK: - InstructionSearchElement
struct InstructionSearchElement: Codable {
    var name: String?
    var steps: [Step]?
}

// MARK: InstructionSearchElement convenience initializers and mutators

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

// MARK: - Step
struct Step: Codable {
    var number: Int?
    var step: String?
    var ingredients, equipment: [Ent]?
    var length: Length?
}

// MARK: Step convenience initializers and mutators

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

// MARK: - Ent
struct Ent: Codable {
    var id: Int?
    var name, localizedName, image: String?
}

// MARK: Ent convenience initializers and mutators

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
struct Length: Codable {
    var number: Int?
    var unit: String?
}

// MARK: Length convenience initializers and mutators

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
