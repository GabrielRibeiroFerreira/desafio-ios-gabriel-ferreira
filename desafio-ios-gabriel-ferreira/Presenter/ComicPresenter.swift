//
//  ComicPresenter.swift
//  desafio-ios-gabriel-ferreira
//
//  Created by Gabriel Ferreira on 28/07/20.
//  Copyright © 2020 Ribeiro Ferreira. All rights reserved.
//

import Foundation

class ComicPresenter {
    private weak var delegate : ComicViewController?
    var imageCallBack : ((_ imageData: NSData) -> Void)?
    
    init(delegate: ComicViewController) {
        self.delegate = delegate
    }
    
    func getImage(from url: String, completion: @escaping (NSData) -> Void) {
        guard let imageURL = URL(string: url) else { return }
        if let image = Cache.imageCache.object(forKey: NSString(string: url)){
            completion(image)
        } else  {
            DispatchQueue.main.async {
                do {
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
