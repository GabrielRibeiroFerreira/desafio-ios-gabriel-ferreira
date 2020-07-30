//
//  ServiceMock.swift
//  desafio-ios-gabriel-ferreiraTests
//
//  Created by Gabriel Ferreira on 29/07/20.
//  Copyright © 2020 Ribeiro Ferreira. All rights reserved.
//

import Foundation
@testable import desafio_ios_gabriel_ferreira

class ServiceMock : ServiceProtocol {
    typealias CallBack = (_ marvelData: [Codable]?, _ status: Bool, _ message:String, _ total: Int?) -> Void
    var callBack: CallBack?

    let characterResponse : [String : Any] =
        ["code":200,
         "status":"Ok",
         "copyright":"© 2020 MARVEL",
         "attributionText":"Data provided by Marvel. © 2020 MARVEL",
         "attributionHTML":"<a href=\"http://marvel.com\">Data provided by Marvel. © 2020 MARVEL</a>",
         "etag":"fdb485b736a02d1ab823fdb882d1a3a7079dc655",
         "data":[
            "offset":0,
            "limit":2,
            "total":4,
            "count":2,
            "results":[
                ["id":1017100,
                 "name":"A-Bomb (HAS)",
                 "description":"Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate! Transformed by a Gamma energy explosion, A-Bomb's thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction! ",
                 "modified":"2013-09-18T15:54:04-0400",
                 "thumbnail":[
                    "path":"http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16",
                    "extension":"jpg"],
                 "resourceURI":"http://gateway.marvel.com/v1/public/characters/1017100",
                 "comics":[
                    "available":0,
                    "collectionURI":"http://gateway.marvel.com/v1/public/characters/1017100/comics",
                    "items":[],
                    "returned":0],
                 "series":[
                    "available":0,
                    "collectionURI":"http://gateway.marvel.com/v1/public/characters/1017100/series",
                    "items":[],
                    "returned":0],
                 "stories":[
                    "available":0,
                    "collectionURI":"http://gateway.marvel.com/v1/public/characters/1017100/stories",
                    "items":[],
                    "returned":0],
                 "events":[
                    "available":0,
                    "collectionURI":"http://gateway.marvel.com/v1/public/characters/1017100/events",
                    "items":[],
                    "returned":0],
                 "urls":[
                    ["type":"detail",
                     "url":"http://marvel.com/comics/characters/1017100/a-bomb_has?utm_campaign=apiRef&utm_source=3f571eccb3e73af23236d572a9811c6a"],
                    ["type":"comiclink",
                     "url":"http://marvel.com/comics/characters/1017100/a-bomb_has?utm_campaign=apiRef&utm_source=3f571eccb3e73af23236d572a9811c6a"]
                    ]
                ],
                ["id":1016823,
                 "name":"Abomination (Ultimate)",
                 "description":"",
                 "modified":"2012-07-10T19:11:52-0400",
                 "thumbnail":[
                    "path":"http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available",
                    "extension":"jpg"],
                 "resourceURI":"http://gateway.marvel.com/v1/public/characters/1016823",
                 "comics":[
                    "available":0,
                    "collectionURI":"http://gateway.marvel.com/v1/public/characters/1016823/comics",
                    "items":[],
                    "returned":0],
                 "series":[
                    "available":0,
                    "collectionURI":"http://gateway.marvel.com/v1/public/characters/1016823/series",
                    "items":[],
                    "returned":0],
                 "stories":[
                    "available":0,
                    "collectionURI":"http://gateway.marvel.com/v1/public/characters/1016823/stories",
                    "items":[],
                    "returned":0],
                 "events":[
                    "available":0,
                    "collectionURI":"http://gateway.marvel.com/v1/public/characters/1016823/events",
                    "items":[],
                    "returned":0],
                 "urls":[
                    ["type":"detail",
                     "url":"http://marvel.com/comics/characters/1016823/abomination_ultimate?utm_campaign=apiRef&utm_source=3f571eccb3e73af23236d572a9811c6a"],
                    ["type":"comiclink",
                     "url":"http://marvel.com/comics/characters/1016823/abomination_ultimate?utm_campaign=apiRef&utm_source=3f571eccb3e73af23236d572a9811c6a"]
                    ]
                ]
            ]
        ]
    ]

    let comicMock : [String : Any] =
        ["code":200,
        "status":"Ok",
        "copyright":"© 2020 MARVEL",
        "attributionText":"Data provided by Marvel. © 2020 MARVEL",
        "attributionHTML":"<a href=\"http://marvel.com\">Data provided by Marvel. © 2020 MARVEL</a>",
        "etag":"9642b4ac0df3d0690e77cc602b0e8dbc74964fcd",
        "data":[
            "offset":0,
            "limit":20,
            "total":3,
            "count":3,
            "results":[
              ["id":40628,
               "digitalId":27099,
               "title":"Hulk (2008) #55",
               "issueNumber":55,
               "variantDescription":"",
               "description":"The hands of the doomsday clock race towards MAYAN RULE! Former Avengers arrive to help stop the end of the world as more Mayan gods return. Rick \"A-Bomb\" Jones falls in battle!",
               "modified":"2012-06-19T11:48:47-0400",
               "isbn":"",
               "upc":"5960605992-05511",
               "diamondCode":"MAY120687",
               "ean":"",
               "issn":"1941-2142",
               "format":"Comic",
               "pageCount":32,
               "textObjects":[],
                "resourceURI":"http://gateway.marvel.com/v1/public/comics/40628",
                "urls":[],
                "series":[
                  "resourceURI":"http://gateway.marvel.com/v1/public/series/3374",
                  "name":"Hulk (2008 - 2012)"],
                "variants":[],
                "collections":[],
                "collectedIssues":[],
                "dates":[],
                "prices":[
                  ["type":"printPrice",
                    "price":2.99],
                  ["type":"digitalPurchasePrice",
                    "price":1.99]],
                "thumbnail":[
                  "path":"http://i.annihil.us/u/prod/marvel/i/mg/6/60/5ba3d0869c543",
                  "extension":"jpg"],
                "images":[],
                "creators":[
                  "available":0,
                  "collectionURI":"http://gateway.marvel.com/v1/public/comics/40628/creators",
                  "items":[],
                  "returned":0],
                "characters":[
                  "available":0,
                  "collectionURI":"http://gateway.marvel.com/v1/public/comics/40628/characters",
                  "items":[],
                  "returned":0],
                "stories":[
                  "available":0,
                  "collectionURI":"http://gateway.marvel.com/v1/public/comics/40628/stories",
                  "items":[],
                  "returned":0],
                "events":[
                  "available":0,
                  "collectionURI":"http://gateway.marvel.com/v1/public/comics/40628/events",
                  "items":[],
                  "returned":0]],
              ["id":40630,
                "digitalId":26830,
                "title":"Hulk (2008) #54",
                "issueNumber":54,
                "variantDescription":"",
                "description":"Mayan Gods! End of the world as we know it! Guest starring Alpha Flight, Machine Man, She-Hulks, A-Bomb!",
                "modified":"2012-06-11T17:31:00-0400",
                "isbn":"",
                "upc":"5960605992-05411",
                "diamondCode":"APR120638",
                "ean":"",
                "issn":"1941-2142",
                "format":"Comic",
                "pageCount":32,
                "textObjects":[],
                "resourceURI":"http://gateway.marvel.com/v1/public/comics/40630",
                "urls":[],
                "series":[
                  "resourceURI":"http://gateway.marvel.com/v1/public/series/3374",
                  "name":"Hulk (2008 - 2012)"],
                "variants":[],
                "collections":[],
                "collectedIssues":[],
                "dates":[],
                "prices":[
                  ["type":"printPrice",
                    "price":2.99],
                  ["type":"digitalPurchasePrice",
                    "price":3.99]],
                "thumbnail":[
                  "path":"http://i.annihil.us/u/prod/marvel/i/mg/f/00/5ba3c7cd5f1e2",
                  "extension":"jpg"],
                "images":[],
                "creators":[
                  "available":0,
                  "collectionURI":"http://gateway.marvel.com/v1/public/comics/40630/creators",
                  "items":[],
                  "returned":0],
                "characters":[
                  "available":0,
                  "collectionURI":"http://gateway.marvel.com/v1/public/comics/40630/characters",
                  "items":[],
                  "returned":0],
                "stories":[
                  "available":0,
                  "collectionURI":"http://gateway.marvel.com/v1/public/comics/40630/stories",
                  "items":[],
                  "returned":0],
                "events":[
                  "available":0,
                  "collectionURI":"http://gateway.marvel.com/v1/public/comics/40630/events",
                  "items":[],
                  "returned":0
                ]
              ]
            ]
          ]
        ]

    
    func getData(from url: String, for dataType: DataType, offset: Int, limit: Int) throws {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self.comicMock, options: [])
            let dataWrapper = try JSONDecoder().decode(DataWrapper<Comic>.self, from: jsonData)
            
            let comics = dataWrapper.data?.results
            let total = dataWrapper.data?.total
            
            self.callBack?(comics, true, "", total)
        } catch {
            print(error)
        }
    }
    
    func completionHandler(callBack: @escaping CallBack) {
        self.callBack = callBack
    }
}

         
