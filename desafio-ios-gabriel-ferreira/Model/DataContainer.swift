//
//  DataContainer.swift
//  desafio-ios-gabriel-ferreira
//
//  Created by Gabriel Ferreira on 24/07/20.
//  Copyright © 2020 Ribeiro Ferreira. All rights reserved.
//

import Foundation

struct DataContainer<Element:Codable> : Codable {
    var offset : Int?
    var limit : Int?
    var total : Int?
    var count : Int?
    var results : [Element]?
    
//    enum CustomerKeys: String, CodingKey
//    {
//        case offset, limit, total, count, results
//    }
//    init (from decoder: Decoder) throws {
//        let container =  try decoder.container (keyedBy: CustomerKeys.self)
//        offset = try container.decode (Int.self, forKey: .offset)
//        limit = try container.decode (Int.self, forKey: .limit)
//        total = try container.decode (Int.self, forKey: .total)
//        count = try container.decode (Int.self, forKey: .count)
//        results = try container.decode ([String: String].self, forKey: .results)
//        let data = try container.decode(Data.self, forKey: .results)
//        results = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//    }
}

//extension JSONDecoder {
//    func decode<T: Decodable>(_ type: T.Type, withJSONObject object: Any, options opt: JSONSerialization.WritingOptions = []) throws -> T {
//        let data = try JSONSerialization.data(withJSONObject: object, options: opt)
//        return try decode(T.self, from: data)
//    }
//}
