//
//  Comic.swift
//  desafio-ios-gabriel-ferreira
//
//  Created by Gabriel Ferreira on 24/07/20.
//  Copyright © 2020 Ribeiro Ferreira. All rights reserved.
//

import Foundation
//Exiba na tela somente a revista mais cara daquele personagem com imagem, título, descrição e o preço.
class Comic : Codable {
    var id : Int?
    var description : String?
    var title : String?
    var prices : [ComicPrice]?
    var thumbnail : Thumbnail?
    
    struct Thumbnail : Codable {
        var path : String?
        var `extension` : String?
    }
    
    struct ComicPrice : Codable {
        var type : String?
        var price : Float?
    }
    
    init(id : Int?, description : String?, title : String?, price : Float?, path : String?, ext : String?) {
        self.id = id
        self.description = description
        self.title = title
        self.prices = [ComicPrice(type: nil, price: price)]
        self.thumbnail = Thumbnail(path: path, extension: ext)
    }
}
