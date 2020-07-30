//
//  CharacterViewController.swift
//  desafio-ios-gabriel-ferreira
//
//  Created by Gabriel Ferreira on 24/07/20.
//  Copyright © 2020 Ribeiro Ferreira. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController {
    var presenter: CharacterPresenter!
    var character : Character!
    var comic : Comic?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var comicButton: UIButton!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.character.name
//        self.nameLabel.text = self.character.name
        if self.character.description?.isEmpty ?? false {
            self.descriptionLabel.text = "The API don't provides description to this character."
        } else {
            self.descriptionLabel.text = self.character.description
        }
        self.imageView.image = self.image
        self.comicButton.isEnabled = false
        self.copyrightLabel.text = Cache.copyright
        self.presenter = CharacterPresenter(delegate: self)
    }
    
    func showComic(comic : Comic) {
        if let button = self.comicButton {
            self.comicButton.isEnabled = true
        }
        self.comic = comic
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toComicSegue" {
            let comicView = segue.destination as! ComicViewController
            comicView.comic = self.comic
            comicView.presenter = ComicPresenter(delegate: comicView)
        }
    }
    
    // MARK: -Errors
    
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: {
            (action : UIAlertAction) in
            if let url = self.character.comics?.collectionURI {
                self.presenter.getData(from: url)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
