//
//  MockSuperHeroesRepository.swift
//  KataSuperHeroes
//
//  Created by Pedro Vicente Gomez on 13/01/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import Foundation
@testable import KataScreenshot

class MockSuperHeroesRepository: SuperHeroesRepository {

    var superHeroes = [SuperHero]()

    override func getAll(_ completion: @escaping ([SuperHero]) -> ()) {
        completion(superHeroes)
    }

    override func getSuperHero(withName name: String, completion: @escaping (SuperHero?, SuperHeroError?) -> ()) {
        let superHeroByName = superHeroes.filter { $0.name == name }.first
        completion(superHeroByName, nil)
    }

}

class MockSuperHeroesErrorRepository: MockSuperHeroesRepository {
    
    var error:SuperHeroError!
    
    override func getSuperHero(withName name: String, completion: @escaping (SuperHero?, SuperHeroError?) -> ()) {
        completion(nil, error)
    }
}

