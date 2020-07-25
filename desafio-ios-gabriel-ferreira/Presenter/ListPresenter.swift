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
    
    func getData() {
        let service = Service()
        do {
            try service.getCharacters(from: "http://gateway.marvel.com/v1/public/characters")
            service.completionHandler { [weak self] (charactersData, status, message) in
                if status {
                    print(message)
                    guard let self = self else {return}
                    guard let characters = charactersData else {return}
                    self.characters = characters
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
    
    func getImage(from url: String, to: IndexPath) {
        guard let imageURL = URL(string: url) else { return }
        DispatchQueue.main.async {
            do{
                let imageData = try Data(contentsOf: imageURL)
                
                self.delegate?.setImage(from: to, to : imageData)
            }catch{
                self.delegate?.showError(title: "Problema com conexão",
                                         message: "Teste sua conexão e tente novamente")
                print(error)
            }
        }
    }
}
