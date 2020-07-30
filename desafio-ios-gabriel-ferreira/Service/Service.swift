//
//  Service.swift
//  desafio-ios-gabriel-ferreira
//
//  Created by Gabriel Ferreira on 24/07/20.
//  Copyright © 2020 Ribeiro Ferreira. All rights reserved.
//

import Foundation
import Alamofire

class Service : ServiceProtocol {
    let timestamp: String = NSDate().timeIntervalSince1970.description
    let publicKey: String = "3f571eccb3e73af23236d572a9811c6a"
    let privateKey: String = "8ca986cc60fe75b08da060874a58bce4d6b2c18e"
    
    typealias CallBack = (_ marvelData: [Codable]?, _ status: Bool, _ message:String, _ total: Int?) -> Void
    var callBack: CallBack?
    
    func getData(from url: String, for dataType: DataType, offset: Int, limit: Int) throws {
        guard NetworkReachabilityManager()?.isReachable ?? false else {
            throw ConnectErrors.receivedFailure
        }
        
        let hash = Hash.MD5(string: self.timestamp + self.privateKey + self.publicKey)
//        DebugPrint: use to create a valid link to test api
//        print(url + "?ts=" + self.timestamp + "&apikey=" + self.publicKey + "&hash=" + hash)
        
        AF.request(url, method: .get, parameters: ["ts": self.timestamp, "apikey": self.publicKey , "hash": hash, "limit": limit, "offset": String(offset)], encoding: URLEncoding.default, headers: nil, interceptor: nil).response {
            (responseData) in
            switch responseData.result {
            case .failure(let error):
                self.callBack?(nil, false, error.errorDescription ?? "", 0)
            case .success(_):
                guard let data = responseData.data else {
                    self.callBack?(nil, false, "API response did not return data", 0)
                    return
                }
                do {
                    let key = Cache.getKey(url: url,
                                           offset: offset,
                                           limit: limit)
                    if responseData.response?.statusCode == 200 {
                        if dataType == .character {
                            let dataWrapper = try JSONDecoder().decode(DataWrapper<Character>.self, from: data)
                            let characters = dataWrapper.data?.results
                            let total = dataWrapper.data?.total
                            Cache.characterCache.setObject(dataWrapper, forKey: NSString(string: key))
                            Cache.copyright = dataWrapper.copyright ?? ""
                            self.callBack?(characters, true, "", total)
                        }else{
                            let dataWrapper = try JSONDecoder().decode(DataWrapper<Comic>.self, from: data)
                            let comics = dataWrapper.data?.results
                            let total = dataWrapper.data?.total
                            Cache.comicCache.setObject(dataWrapper, forKey: NSString(string: key))
                            Cache.copyright = dataWrapper.copyright ?? ""
                            self.callBack?(comics, true, "", total)
                        }
                    } else {
                        let errorMessage = try JSONDecoder().decode(ErrorMessage.self, from: data)
                        self.callBack?(nil, false, errorMessage.status, 0)
                    }
                } catch {
                    self.callBack?(nil, false, error.localizedDescription, 0)
                }
            }
        }
    }
    
    func completionHandler(callBack: @escaping CallBack) {
        self.callBack = callBack
    }
}
