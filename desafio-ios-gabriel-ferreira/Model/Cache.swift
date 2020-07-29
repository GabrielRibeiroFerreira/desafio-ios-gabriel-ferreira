//
//  Cache.swift
//  desafio-ios-gabriel-ferreira
//
//  Created by Gabriel Ferreira on 28/07/20.
//  Copyright © 2020 Ribeiro Ferreira. All rights reserved.
//

import Foundation

struct Cache {
    static let imageCache = NSCache<NSString, NSData>()
    static let characterCache = NSCache<NSString, DataWrapper<Character>>()
    static let comicCache = NSCache<NSString, DataWrapper<Comic>>()
    static var copyright: String = ""
    static func getKey(url: String, offset: Int, limit: Int) -> String {
        let key = url + String(offset) + "/" + String(limit)
        return key
    }
}

