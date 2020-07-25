//
//  CharacterDataContainer.swift
//  desafio-ios-gabriel-ferreira
//
//  Created by Gabriel Ferreira on 24/07/20.
//  Copyright © 2020 Ribeiro Ferreira. All rights reserved.
//

import Foundation

struct CharacterDataContainer : Decodable {
    var offset : Int?
    var limit : Int?
    var total : Int?
    var count : Int?
    var results : [Character]?
}
