//
//  Service.swift
//  desafio-ios-gabriel-ferreira
//
//  Created by Gabriel Ferreira on 24/07/20.
//  Copyright © 2020 Ribeiro Ferreira. All rights reserved.
//

import Foundation
import Alamofire

class Service {
    let timestamp = NSDate().timeIntervalSince1970.description
    let publicKey: String = "3f571eccb3e73af23236d572a9811c6a"
    let privateKey: String = "8ca986cc60fe75b08da060874a58bce4d6b2c18e"
    typealias characterCallBack = (_ character: [Character]?, _ status: Bool, _ message:String) -> Void
    var callBack: characterCallBack?
    
    func getCharacters(from : String) throws {
        guard NetworkReachabilityManager()?.isReachable ?? false else {
            throw ConnectErrors.receivedFailure
        }
        
        let hash = Hash.MD5(string: self.timestamp + self.privateKey + self.publicKey)
//        print("ts=" + timestamp + "&apikey=" + publicKey + "&hash=" + hash)
//        print("teste " + Hash.MD5(string: "1abcd1234"))
        
        AF.request(from, method: .get, parameters: ["ts": self.timestamp, "apikey": self.publicKey , "hash": hash], encoding: URLEncoding.default, headers: nil, interceptor: nil).response {
            (responseData) in
            guard let data = responseData.data else {
                self.callBack?(nil, false, "")
                return}
                print(data)
            do {
                let marvelData = try JSONDecoder().decode(CharacterDataWrapper.self, from: data)
                self.callBack?(marvelData.data?.results, true, "")
            } catch {
                self.callBack?(nil, false, error.localizedDescription)
            }
        }
        
    }
    
    func completionHandler(callBack: @escaping characterCallBack) {
        self.callBack = callBack
    }
}
