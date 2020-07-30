//
//  ListTableViewController.swift
//  desafio-ios-gabriel-ferreira
//
//  Created by Gabriel Ferreira on 23/07/20.
//  Copyright © 2020 Ribeiro Ferreira. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    var presenter : ListPresenter!
    
    @IBOutlet weak var previousButton: UIBarButtonItem!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    let characterCellIdentifier : String = "CharacterTableViewCell"
    
    var actualCharacter : Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = ListPresenter(delegate: self)
        self.presenter.getData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let nib = UINib.init(nibName: self.characterCellIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: self.characterCellIdentifier)
        
        self.nextButton.isEnabled = false
        self.previousButton.isEnabled = false
    }
    
    func enablePagination(pages : Int, actualPage: Int) {
        self.nextButton.isEnabled = actualPage < pages
        self.previousButton.isEnabled  = actualPage > 0
    }

    @IBAction func nextAction(_ sender: Any) {
        self.presenter.updatePage(isNext: true)
    }
    
    @IBAction func previousAction(_ sender: Any) {
        self.presenter.updatePage(isNext: false)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = Cache.copyright
        label.textAlignment = .center
        label.backgroundColor = UIColor.systemBackground
        return label
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.getNumberOfRows()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.characterCellIdentifier, for: indexPath) as! CharacterTableViewCell

        let character : Character = self.presenter.getCharacter(forCell: indexPath.row)
        
        cell.name.text = character.name
        if let path = character.thumbnail?.path,
            let ext = character.thumbnail?.extension {
            let imgURL =  path + "." +  ext
            cell.imgURL = imgURL
            self.presenter.getImage(from: imgURL) { (imageData) in
                cell.img.image = UIImage(data: imageData as Data)
            }
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.actualCharacter = self.presenter.getCharacter(forCell: indexPath.row)
        performSegue(withIdentifier: "toCharacterSegue", sender: self)
    }
    
    func setImage(from indexPath: IndexPath, to data: Data) {
        let cell = tableView.cellForRow(at: indexPath) as! CharacterTableViewCell
        
        cell.img.image = UIImage(data: data)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCharacterSegue" {
            let characterView = segue.destination as! CharacterViewController
            characterView.character = self.actualCharacter
            if let path = self.actualCharacter?.thumbnail?.path,
                let ext = self.actualCharacter?.thumbnail?.extension {
                let imgURL =  path + "." + ext
                self.presenter.getImage(from: imgURL) { (imageData) in
                    characterView.image = UIImage(data: imageData as Data)
                }
            }
        }
    }
    
    // MARK: -Errors
    
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: {
            (action : UIAlertAction) in
            self.presenter.getData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
