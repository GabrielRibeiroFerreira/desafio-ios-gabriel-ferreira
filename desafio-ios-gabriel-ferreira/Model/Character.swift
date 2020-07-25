//
//  Character.swift
//  desafio-ios-gabriel-ferreira
//
//  Created by Gabriel Ferreira on 23/07/20.
//  Copyright © 2020 Ribeiro Ferreira. All rights reserved.
//

import Foundation
import UIKit
//Exiba a imagem do personagem, o nome, a descrição e um botão de direcionamento para a uma tela que mostre qual a HQ mais cara daquele personagem.
struct Character : Decodable {
    static let imageCache = NSCache<NSString, UIImage>()
    var id : Int?
    var name : String?
    var description : String?
    var thumbnail : Thumbnail?
    struct Thumbnail : Decodable {
        var path : String?
        var `extension` : String?
    }
}
