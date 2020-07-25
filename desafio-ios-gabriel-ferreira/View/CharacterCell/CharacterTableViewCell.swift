//
//  CharacterTableViewCell.swift
//  desafio-ios-gabriel-ferreira
//
//  Created by Gabriel Ferreira on 23/07/20.
//  Copyright © 2020 Ribeiro Ferreira. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var img: UIImageView!
    var imgURL: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getImage(from url: String){
        guard let imageURL = URL(string: url) else { return }
        if let image = Character.imageCache.object(forKey: NSString(string: url)){
            self.img.image = image
            return
        }
        DispatchQueue.main.async {
            do{
                let imageData = try Data(contentsOf: imageURL)
                self.imgURL = url
                let image = UIImage(data: imageData)
                self.img.image = image
                Character.imageCache.setObject(image!, forKey: NSString(string: url))
            }catch{
//                self.delegate?.showError(title: "Problema com conexão",
//                                         message: "Teste sua conexão e tente novamente")
//                print(error)
            }
        }
    }
}
