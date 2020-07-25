//
//  Comic.swift
//  desafio-ios-gabriel-ferreira
//
//  Created by Gabriel Ferreira on 24/07/20.
//  Copyright © 2020 Ribeiro Ferreira. All rights reserved.
//

import Foundation
//Exiba na tela somente a revista mais cara daquele personagem com imagem, título, descrição e o preço.
struct Comic : Decodable {
    var id : Int
    var title : String
    var description : String
    var price : Float
}
