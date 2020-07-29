//
//  desafio_ios_gabriel_ferreiraTests.swift
//  desafio-ios-gabriel-ferreiraTests
//
//  Created by Gabriel Ferreira on 23/07/20.
//  Copyright © 2020 Ribeiro Ferreira. All rights reserved.
//

import XCTest
@testable import desafio_ios_gabriel_ferreira

class desafio_ios_gabriel_ferreiraTests: XCTestCase {
    var service: Service!

    override func setUpWithError() throws {
        super.setUp()
        service = Service()
    }
    
    func testCharactersAtComic() {
        let url = "http://gateway.marvel.com/v1/public/characters"
        let offset = 0
        let limit = 100
        var received = false
        do {
            try self.service.getData(from: url, for: .comic, offset: offset, limit: limit)
            self.service.completionHandler { (data, status, message, total) in
                if status {
                    print(message)
                    guard let _ = data as? [Comic] else {return}
                    received = true
                }
            }
        }catch ConnectErrors.receivedFailure{
            print(ConnectErrors.receivedFailure)
        }catch{
            print(error)
        }
        XCTAssertEqual(received, false, "comics receving characters data")
    }
    
    func testComicAtCharacters() {
        let url = "http://gateway.marvel.com/v1/public/characters/1017100/comics"
        let offset = 0
        let limit = 100
        var received = false
        do {
            try self.service.getData(from: url, for: .character, offset: offset, limit: limit)
            self.service.completionHandler { (data, status, message, total) in
                if status {
                    print(message)
                    guard let _ = data as? [Character] else {return}
                    received = true
                }
            }
        }catch ConnectErrors.receivedFailure{
            print(ConnectErrors.receivedFailure)
        }catch{
            print(error)
        }
        XCTAssertEqual(received, false, "characters receving comics data")
    }
}
