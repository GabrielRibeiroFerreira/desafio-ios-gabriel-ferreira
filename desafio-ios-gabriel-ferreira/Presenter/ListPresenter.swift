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
    var service : ServiceProtocol!
    var limit : Int = 20
    var offset : Int = 0
    var pages : Int?
    
    init(delegate: ListTableViewController) {
        self.delegate = delegate
        self.service = Service()
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
        if !self.getDataFromCache(key: key) {
            self.getDataFromService()
        }
    }
    
    func getDataFromCache(key: String) -> Bool {
        var worked = false
        if let dataWrapper = Cache.characterCache.object(forKey: key as NSString) {
            guard let characters = dataWrapper.data?.results else { return false }
            self.characters = characters
            let total = dataWrapper.data?.total
            self.pages = (total ?? 0)/self.limit
            let actualPage = self.offset/self.limit
            self.delegate?.enablePagination(pages: pages!, actualPage: actualPage)
            self.delegate?.tableView.reloadData()
            
            worked = true
        }
        
        return worked
    }
    
    func getDataFromService() {
        do {
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
                } else {
                    self?.delegate?.showError(title: "Service error",
                                             message: "Problem with connecting to the server, update the application or contact us")
                }
            }
            try service.getData(from: "http://gateway.marvel.com/v1/public/characters", for: .character, offset: self.offset, limit: self.limit)
        }catch ConnectErrors.receivedFailure{
            self.delegate?.showError(title: "Connection problem",
                                     message: "The comic is not available due to lack of internet connection")
        }catch{
            print(error)
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
                       self.delegate?.showError(title: "Connection problem",
                                                message: "The comic is not available due to lack of internet connection")
                       print(error)
                }
            }
        }
    }
}
