//
//  CharacterViewController.swift
//  desafio-ios-gabriel-ferreira
//
//  Created by Gabriel Ferreira on 24/07/20.
//  Copyright © 2020 Ribeiro Ferreira. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController {
    var character : Character!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.character.name
        self.nameLabel.text = self.character.name
        self.descriptionLabel.text = self.character.description
        if let path = character.thumbnail?.path,
            let ext = character.thumbnail?.extension {
            let key =  path + "." +  ext

            self.image.image = Character.imageCache.object(forKey: NSString(string: key))
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
