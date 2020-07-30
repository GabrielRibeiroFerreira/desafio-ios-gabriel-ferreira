//
//  ServiceProtocol.swift
//  desafio-ios-gabriel-ferreira
//
//  Created by Gabriel Ferreira on 29/07/20.
//  Copyright © 2020 Ribeiro Ferreira. All rights reserved.
//

import Foundation

protocol ServiceProtocol {
    typealias CallBack = (_ marvelData: [Codable]?, _ status: Bool, _ message:String, _ total: Int?) -> Void
    var callBack: CallBack? { get }
    
    func getData(from url: String, for dataType: DataType, offset: Int, limit: Int) throws
    
    func completionHandler(callBack: @escaping CallBack)
}
