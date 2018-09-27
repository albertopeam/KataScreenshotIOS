//
//  GetSuperHeroByName.swift
//  KataSuperHeroes
//
//  Created by Pedro Vicente Gomez on 12/01/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import Foundation

class GetSuperHeroByName {

    fileprivate let repository: SuperHeroesRepository

    init(repository: SuperHeroesRepository) {
        self.repository = repository
    }

    func execute(_ superHeroName: String, completion: @escaping (SuperHero?, SuperHeroError?) -> () ) {
        repository.getSuperHero(withName: superHeroName) { (superHero, error) in
            completion(superHero, error)
        }
    }

}
