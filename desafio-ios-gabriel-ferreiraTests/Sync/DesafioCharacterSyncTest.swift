//
//  DesafioCharacterSyncTest.swift
//  desafio-ios-gabriel-ferreiraTests
//
//  Created by Gabriel Ferreira on 29/07/20.
//  Copyright © 2020 Ribeiro Ferreira. All rights reserved.
//

import XCTest
@testable import desafio_ios_gabriel_ferreira

class DesafioCharacterSyncTest: XCTestCase {
    var serviceMock : ServiceMock = ServiceMock()
    var characterView : CharacterViewController = CharacterViewController()
    var characterPresenter : CharacterPresenter?

    override func setUp() {
        super.setUp()
        
        let character = Character()
        
        self.characterView.character = character
        self.characterPresenter = CharacterPresenter(delegate: self.characterView)
        self.characterPresenter?.service = self.serviceMock
    }
    
    func testGetComic() {
        self.characterPresenter?.getDataFromService(url: "")
        let price = self.characterView.comic?.getHigherPrice()
        let title = self.characterView.comic?.title
        
        XCTAssertEqual(price, 3.99, "getting higher price comic error")
        XCTAssertEqual(title, "Hulk (2008) #54", "getting higher price comic title error")
    }
}
