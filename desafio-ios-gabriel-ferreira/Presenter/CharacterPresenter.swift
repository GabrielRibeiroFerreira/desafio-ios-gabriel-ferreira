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
    
    init(delegate: CharacterViewController) {
        self.delegate = delegate
        if let url = delegate.character.comics?.collectionURI {
            self.getData(from: url)
        }
    }
    
    func getData(from comicURL: String) {
        let key = Cache.getKey(url: comicURL,
                               offset: self.offset,
                               limit: self.limit)
        if let dataWrapper = Cache.comicCache.object(forKey: key as NSString) {
            guard let comics = dataWrapper.data?.results else { return }
            self.comics = comics
            
            if let comic = self.getComic(from: comics) {
                self.delegate?.showComic(comic: comic)
            }
        } else  {
            let service = Service()
            do {
                try service.getData(from: comicURL, for: .comic, offset: self.offset, limit: self.limit)
                service.completionHandler { [weak self] (comicData, status, message, total) in
                    if status {
                        print(message)
                        guard let self = self else {return}
                        guard let comics = comicData as? [Comic] else {return}
                        self.comics = comics
                        
                        if let comic = self.getComic(from: comics) {
                            self.delegate?.showComic(comic: comic)
                        }
                    }
                }
            }catch ConnectErrors.receivedFailure{
                self.delegate?.showError(title: "Problema com conexão",
                                         message: "Teste sua conexão e tente novamente")
            }catch{
                print(error)
            }
        }
    }
    
    func getComic(from comics: [Comic]) -> Comic? {
        var actualComic : Comic?
        
        for comic in comics {
            guard let prices = comic.prices else { continue }
            
            for price in prices {
                guard let comicPrice = price.price else { continue }
                
                if let actualPrice = actualComic?.prices?.first?.price {
                    if comicPrice >= actualPrice {
                        actualComic = Comic(id: comic.id,
                                            description: comic.description,
                                            title: comic.title,
                                            price: comicPrice,
                                            path: comic.thumbnail?.path,
                                            ext: comic.thumbnail?.extension)
                    }
                } else {
                    actualComic = Comic(id: comic.id,
                                        description: comic.description,
                                        title: comic.title,
                                        price: comicPrice,
                                        path: comic.thumbnail?.path,
                                        ext: comic.thumbnail?.extension)
                }
            }
        }
        
        return actualComic
    }
}
