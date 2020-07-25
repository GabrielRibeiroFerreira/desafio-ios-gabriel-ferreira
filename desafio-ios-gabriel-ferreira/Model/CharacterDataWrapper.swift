//
//  CharacterDataWrapper.swift
//  desafio-ios-gabriel-ferreira
//
//  Created by Gabriel Ferreira on 24/07/20.
//  Copyright © 2020 Ribeiro Ferreira. All rights reserved.
//

import Foundation

struct CharacterDataWrapper : Decodable {
    var code : Int?
    var status : String?
    var copyright : String?
    var attributionText : String?
    var attributionHTML : String?
    var etag : String?
    var data : CharacterDataContainer?    
}
