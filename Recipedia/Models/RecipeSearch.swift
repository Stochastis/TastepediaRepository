//////
//////  RecipeSearch.swift
//////  Recipedia (iOS)
//////
//////  Created by Caleb Ross on 3/3/22.
//
//import Foundation
//
//// MARK: - RecipeSearchElement
//struct RecipeSearch: Codable, Identifiable {
//    let id: Int?
//    let title: String?
//    let image: String?
//    let imageType: ImageType?
//    let usedIngredientCount, missedIngredientCount: Int?
//    let missedIngredients, usedIngredients, unusedIngredients: [SedIngredient]?
//    let likes: Int?
//}
//
//enum ImageType: String, Codable {
//    case jpg = "jpg"
//}
//
////
//// To read values from URLs:
////
////   let task = URLSession.shared.sedIngredientTask(with: url) { sedIngredient, response, error in
////     if let sedIngredient = sedIngredient {
////       ...
////     }
////   }
////   task.resume()
//
//// MARK: - SedIngredient
//struct SedIngredient: Codable, Identifiable {
//    let id: Int?
//    let amount: Double?
//    let unit, unitLong, unitShort, aisle: String?
//    let name, original, originalName: String?
//    let meta: [String]?
//    let image: String?
//    let extendedName: String?
//}
//
//
//// MARK: RecipeSearchElement convenience initializers and mutators
//
//extension RecipeSearch {
//    init(data: Data) throws {
//        self = try newJSONDecoder().decode(RecipeSearch.self, from: data)
//    }
//
//    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
//        guard let data = json.data(using: encoding) else {
//            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
//        }
//        try self.init(data: data)
//    }
//
//    init(fromURL url: URL) throws {
//        try self.init(data: try Data(contentsOf: url))
//    }
//
//    func with(
//        id: Int?? = nil,
//        title: String?? = nil,
//        image: String?? = nil,
//        imageType: ImageType?? = nil,
//        usedIngredientCount: Int?? = nil,
//        missedIngredientCount: Int?? = nil,
//        missedIngredients: [SedIngredient]?? = nil,
//        usedIngredients: [SedIngredient]?? = nil,
//        unusedIngredients: [SedIngredient]?? = nil,
//        likes: Int?? = nil
//    ) -> RecipeSearch {
//        return RecipeSearch(
//            id: id ?? self.id,
//            title: title ?? self.title,
//            image: image ?? self.image,
//            imageType: imageType ?? self.imageType,
//            usedIngredientCount: usedIngredientCount ?? self.usedIngredientCount,
//            missedIngredientCount: missedIngredientCount ?? self.missedIngredientCount,
//            missedIngredients: missedIngredients ?? self.missedIngredients,
//            usedIngredients: usedIngredients ?? self.usedIngredients,
//            unusedIngredients: unusedIngredients ?? self.unusedIngredients,
//            likes: likes ?? self.likes
//        )
//    }
//
//    func jsonData() throws -> Data {
//        return try newJSONEncoder().encode(self)
//    }
//
//    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
//        return String(data: try self.jsonData(), encoding: encoding)
//    }
//}
//
////
//// To read values from URLs:
////
////   let task = URLSession.shared.sedIngredientTask(with: url) { sedIngredient, response, error in
////     if let sedIngredient = sedIngredient {
////       ...
////     }
////   }
////   task.resume()
//
//// MARK: SedIngredient convenience initializers and mutators
//
//extension SedIngredient {
//    init(data: Data) throws {
//        self = try newJSONDecoder().decode(SedIngredient.self, from: data)
//    }
//
//    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
//        guard let data = json.data(using: encoding) else {
//            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
//        }
//        try self.init(data: data)
//    }
//
//    init(fromURL url: URL) throws {
//        try self.init(data: try Data(contentsOf: url))
//    }
//
//    func with(
//        id: Int?? = nil,
//        amount: Double?? = nil,
//        unit: String?? = nil,
//        unitLong: String?? = nil,
//        unitShort: String?? = nil,
//        aisle: String?? = nil,
//        name: String?? = nil,
//        original: String?? = nil,
//        originalName: String?? = nil,
//        meta: [String]?? = nil,
//        image: String?? = nil,
//        extendedName: String?? = nil
//    ) -> SedIngredient {
//        return SedIngredient(
//            id: id ?? self.id,
//            amount: amount ?? self.amount,
//            unit: unit ?? self.unit,
//            unitLong: unitLong ?? self.unitLong,
//            unitShort: unitShort ?? self.unitShort,
//            aisle: aisle ?? self.aisle,
//            name: name ?? self.name,
//            original: original ?? self.original,
//            originalName: originalName ?? self.originalName,
//            meta: meta ?? self.meta,
//            image: image ?? self.image,
//            extendedName: extendedName ?? self.extendedName
//        )
//    }
//
//    func jsonData() throws -> Data {
//        return try newJSONEncoder().encode(self)
//    }
//
//    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
//        return String(data: try self.jsonData(), encoding: encoding)
//    }
//}
////
////typealias RecipeSearch = [RecipeSearch]
////
////extension Array where Element == RecipeSearch.Element {
////    init(data: Data) throws {
////        self = try newJSONDecoder().decode(RecipeSearch.self, from: data)
////    }
////
////    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
////        guard let data = json.data(using: encoding) else {
////            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
////        }
////        try self.init(data: data)
////    }
////
////    init(fromURL url: URL) throws {
////        try self.init(data: try Data(contentsOf: url))
////    }
////
////    func jsonData() throws -> Data {
////        return try newJSONEncoder().encode(self)
////    }
////
////    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
////        return String(data: try self.jsonData(), encoding: encoding)
////    }
////}
//
//// MARK: - Helper functions for creating encoders and decoders
//
//func newJSONDecoder() -> JSONDecoder {
//    let decoder = JSONDecoder()
//    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
//        decoder.dateDecodingStrategy = .iso8601
//    }
//    return decoder
//}
//
//func newJSONEncoder() -> JSONEncoder {
//    let encoder = JSONEncoder()
//    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
//        encoder.dateEncodingStrategy = .iso8601
//    }
//    return encoder
//}
//
//// MARK: - URLSession response handlers
//
//extension URLSession {
//    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
//        return self.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else {
//                completionHandler(nil, response, error)
//                return
//            }
//            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
//        }
//    }
//
//    func recipeSearchTask(with url: URL, completionHandler: @escaping (RecipeSearch?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
//        return self.codableTask(with: url, completionHandler: completionHandler)
//    }
//}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let recipeSearch = try RecipeSearch(json)

//
// To read values from URLs:
//
//   let task = URLSession.shared.recipeSearchElementTask(with: url) { recipeSearchElement, response, error in
//     if let recipeSearchElement = recipeSearchElement {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - RecipeSearchElement
struct RecipeSearchElement: Codable {
    var id: Int?
    var title: String?
    var image: String?
    var imageType: ImageType?
    var usedIngredientCount, missedIngredientCount: Int?
    var missedIngredients, usedIngredients, unusedIngredients: [SedIngredient]?
    var likes: Int?
}

// MARK: RecipeSearchElement convenience initializers and mutators

extension RecipeSearchElement {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(RecipeSearchElement.self, from: data)
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
        title: String?? = nil,
        image: String?? = nil,
        imageType: ImageType?? = nil,
        usedIngredientCount: Int?? = nil,
        missedIngredientCount: Int?? = nil,
        missedIngredients: [SedIngredient]?? = nil,
        usedIngredients: [SedIngredient]?? = nil,
        unusedIngredients: [SedIngredient]?? = nil,
        likes: Int?? = nil
    ) -> RecipeSearchElement {
        return RecipeSearchElement(
            id: id ?? self.id,
            title: title ?? self.title,
            image: image ?? self.image,
            imageType: imageType ?? self.imageType,
            usedIngredientCount: usedIngredientCount ?? self.usedIngredientCount,
            missedIngredientCount: missedIngredientCount ?? self.missedIngredientCount,
            missedIngredients: missedIngredients ?? self.missedIngredients,
            usedIngredients: usedIngredients ?? self.usedIngredients,
            unusedIngredients: unusedIngredients ?? self.unusedIngredients,
            likes: likes ?? self.likes
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum ImageType: String, Codable {
    case jpg = "jpg"
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.sedIngredientTask(with: url) { sedIngredient, response, error in
//     if let sedIngredient = sedIngredient {
//       ...
//     }
//   }
//   task.resume()

// MARK: - SedIngredient
struct SedIngredient: Codable {
    var id: Int?
    var amount: Double?
    var unit, unitLong, unitShort, aisle: String?
    var name, original, originalName: String?
    var meta: [String]?
    var image: String?
    var extendedName: String?
}

// MARK: SedIngredient convenience initializers and mutators

extension SedIngredient {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SedIngredient.self, from: data)
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
        amount: Double?? = nil,
        unit: String?? = nil,
        unitLong: String?? = nil,
        unitShort: String?? = nil,
        aisle: String?? = nil,
        name: String?? = nil,
        original: String?? = nil,
        originalName: String?? = nil,
        meta: [String]?? = nil,
        image: String?? = nil,
        extendedName: String?? = nil
    ) -> SedIngredient {
        return SedIngredient(
            id: id ?? self.id,
            amount: amount ?? self.amount,
            unit: unit ?? self.unit,
            unitLong: unitLong ?? self.unitLong,
            unitShort: unitShort ?? self.unitShort,
            aisle: aisle ?? self.aisle,
            name: name ?? self.name,
            original: original ?? self.original,
            originalName: originalName ?? self.originalName,
            meta: meta ?? self.meta,
            image: image ?? self.image,
            extendedName: extendedName ?? self.extendedName
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

typealias RecipeSearch = [RecipeSearchElement]

extension Array where Element == RecipeSearch.Element {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(RecipeSearch.self, from: data)
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

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
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

    func recipeSearchTask(with url: URL, completionHandler: @escaping (RecipeSearch?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
