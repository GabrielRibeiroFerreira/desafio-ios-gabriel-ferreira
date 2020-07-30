//
//  ComicViewController.swift
//  desafio-ios-gabriel-ferreira
//
//  Created by Gabriel Ferreira on 27/07/20.
//  Copyright © 2020 Ribeiro Ferreira. All rights reserved.
//

import UIKit

class ComicViewController: UIViewController {
    var comic : Comic!
    var presenter : ComicPresenter!
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.comic.title
        self.priceLabel.text = self.comic.prices?.first?.price?.description
        self.descriptionLabel.text = self.comic.description
        self.copyrightLabel.text = Cache.copyright
        
        if let path = self.comic.thumbnail?.path,
            let ext = self.comic.thumbnail?.extension {
            let url = path + "." + ext
            self.presenter.getImage(from: url) { (imageData) in
                let image = UIImage(data: imageData as Data)
                self.image.image = image
            }
        }
    }
    
    
    // MARK: -Errors
    
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: {
            (action : UIAlertAction) in
            if let path = self.comic.thumbnail?.path,
                let ext = self.comic.thumbnail?.extension {
                let url = path + "." + ext
                self.presenter.getImage(from: url) { (imageData) in
                    let image = UIImage(data: imageData as Data)
                    self.image.image = image
                }
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
