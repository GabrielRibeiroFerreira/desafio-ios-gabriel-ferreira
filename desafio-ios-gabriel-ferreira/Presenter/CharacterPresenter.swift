//
//  CharacterPresenter.swift
//  desafio-ios-gabriel-ferreira
//
//  Created by Gabriel Ferreira on 25/07/20.
//  Copyright © 2020 Ribeiro Ferreira. All rights reserved.
//

import Foundation

class CharacterPresenter {
    private weak var delegate : CharacterViewController?
    private var comics : [Comic] = []
    var limit : Int = 100
    var offset : Int = 0
    var service : ServiceProtocol!
    
    init(delegate: CharacterViewController) {
        self.delegate = delegate
        
        self.service = Service()
        if let url = delegate.character.comics?.collectionURI {
            self.getData(from: url)
            
            //TO-DO: get all the comics (for now only works for the first 100)
//            repeat {
//                self.getData(from: url)
//                self.offset += self.limit
//            } while offset + limit < self.delegate?.character.comics?.available ?? 0
        }
    }
    
    func getData(from comicURL: String) {
        let key = Cache.getKey(url: comicURL,
                               offset: self.offset,
                               limit: self.limit)
        
        if !self.getDataFromCache(key: key) {
            self.getDataFromService(url: comicURL)
        }
    }
    
    func getDataFromCache(key : String) -> Bool {
        var worked = false
        if let dataWrapper = Cache.comicCache.object(forKey: key as NSString) {
            guard let comics = dataWrapper.data?.results else { return worked }
            self.comics = comics
            
            if let comic = self.getComic(from: comics) {
                self.delegate?.showComic(comic: comic)
            }
            worked = true
        }
        return worked
    }
    
    func getDataFromService(url: String) {
        do {
            self.service.completionHandler { [weak self] (comicData, status, message, total) in
                if status {
                    print(message)
                    guard let self = self else {return}
                    guard let comics = comicData as? [Comic] else {return}
                    self.comics = comics
                    
                    if let comic = self.getComic(from: comics) {
                        self.delegate?.showComic(comic: comic)
                    }
                } else {
                    self?.delegate?.showError(title: "Service error",
                                             message: "Problem with connecting to the server, update the application or contact us")
                }
            }
            try self.service.getData(from: url, for: .comic, offset: self.offset, limit: self.limit)
        }catch ConnectErrors.receivedFailure{
            self.delegate?.showError(title: "Connection problem",
                                     message: "The comic is not available due to lack of internet connection")
        }catch{
            print(error)
        }
    }
    
    func getComic(from comics: [Comic]) -> Comic? {
        var actualComic : Comic?
        
        for comic in comics {
            guard let price = comic.getHigherPrice() else { continue }
            guard let actualPrice = actualComic?.getHigherPrice() else {
                actualComic = Comic(id: comic.id,
                                    description: comic.description,
                                    title: comic.title,
                                    price: price,
                                    path: comic.thumbnail?.path,
                                    ext: comic.thumbnail?.extension)
                continue
            }
            
            if price > actualPrice {
                actualComic = Comic(id: comic.id,
                                    description: comic.description,
                                    title: comic.title,
                                    price: price,
                                    path: comic.thumbnail?.path,
                                    ext: comic.thumbnail?.extension)
            }
        }
        
        return actualComic
    }
}
