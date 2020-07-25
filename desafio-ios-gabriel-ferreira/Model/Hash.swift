//
//  Hash.swift
//  desafio-ios-gabriel-ferreira
//
//  Created by Gabriel Ferreira on 24/07/20.
//  Copyright © 2020 Ribeiro Ferreira. All rights reserved.
//

import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

class Hash {
    static func MD5(string: String) -> String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        
            
        let res = digestData.map { String(format: "%02hhx", $0) }.joined()
        
        return res
    }

    //Test:
//    let md5Data = MD5(string:"Hello")
//
//    let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
//    print("md5Hex: \(md5Hex)")
//
//    let md5Base64 = md5Data.base64EncodedString()
//    print("md5Base64: \(md5Base64)")
}
