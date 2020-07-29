//
//  ListPresenter.swift
//  desafio-ios-gabriel-ferreira
//
//  Created by Gabriel Ferreira on 23/07/20.
//  Copyright © 2020 Ribeiro Ferreira. All rights reserved.
//

import Foundation

class ListPresenter {
    private weak var delegate : ListTableViewController?
    private var characters : [Character] = []
    var imageCallBack : ((_ imageData: NSData) -> Void)?
    var limit : Int = 20
    var offset : Int = 0
    
    init(delegate: ListTableViewController) {
        self.delegate = delegate
        self.getData()
    }
    
    func getCharacter(forCell index: Int) -> Character {
        return self.characters[index]
    }
    
    func getNumberOfRows() -> Int {
        return self.characters.count
    }
    
    func updatePage(isNext: Bool) {
        self.offset = self.offset + (isNext ? self.limit : (self.limit * -1))
        self.getData()
    }
    
    func getData() {
        let key = Cache.getKey(url: "http://gateway.marvel.com/v1/public/characters",
                               offset: self.offset,
                               limit: self.limit)
        if let dataWrapper = Cache.characterCache.object(forKey: key as NSString) {
            guard let characters = dataWrapper.data?.results else { return }
            self.characters = characters
            let total = dataWrapper.data?.total
            let pages = (total ?? 0)/self.limit
            let actualPage = self.offset/self.limit
            self.delegate?.enablePagination(pages: pages, actualPage: actualPage)
            self.delegate?.tableView.reloadData()
        } else  {
            let service = Service()
            do {
                try service.getData(from: "http://gateway.marvel.com/v1/public/characters", for: .character, offset: self.offset, limit: self.limit)
                service.completionHandler { [weak self] (charactersData, status, message, total) in
                    if status {
                        print(message)
                        guard let self = self else {return}
                        guard let characters = charactersData as? [Character] else {return}
                        self.characters = characters
                        let pages = (total ?? 0)/self.limit
                        let actualPage = self.offset/self.limit
                        self.delegate?.enablePagination(pages: pages, actualPage: actualPage)
                        self.delegate?.tableView.reloadData()
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
    
    func getImage(from url: String, completion: @escaping (NSData) -> Void) {
        guard let imageURL = URL(string: url) else { return }
        if let image = Cache.imageCache.object(forKey: NSString(string: url)){
            completion(image)
        } else  {
            DispatchQueue.main.async {
                do{
                    let imageData = try Data(contentsOf: imageURL)
                    Cache.imageCache.setObject(imageData as NSData, forKey: NSString(string: url))
                    completion(imageData as NSData)
                }catch{
        //               self.delegate?.showError(title: "Problema com conexão",
        //                                        message: "Teste sua conexão e tente novamente")
        //               print(error)
                }
            }
        }
    }
}
