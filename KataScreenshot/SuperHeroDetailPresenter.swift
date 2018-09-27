//
//  SuperHeroDetailPresenter.swift
//  KataSuperHeroes
//
//  Created by Pedro Vicente Gomez on 12/01/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import Foundation
import BothamUI

class SuperHeroDetailPresenter: BothamPresenter {

    fileprivate weak var ui: SuperHeroDetailUI?
    fileprivate let superHeroName: String
    fileprivate let getSuperHeroByName: GetSuperHeroByName

    init(ui: SuperHeroDetailUI, superHeroName: String, getSuperHeroByName: GetSuperHeroByName) {
        self.ui = ui
        self.superHeroName = superHeroName
        self.getSuperHeroByName = getSuperHeroByName
    }

    func viewDidLoad() {
        ui?.title = superHeroName
        ui?.showLoader()
        getSuperHeroByName.execute(superHeroName) { (superHero, error) in
            if let hero = superHero {
                self.ui?.hideLoader()
                self.ui?.show(superHero: hero)
            }else if let error = error {
                self.ui?.hideLoader()
                switch error {                    
                case .notFound:
                    self.ui?.error(error: "not found")
                case .noInternet:
                    self.ui?.error(error: "no network")
                }
            }
        }
    }

}

protocol SuperHeroDetailUI: BothamLoadingUI {

    var title: String? {get set}
    func show(superHero: SuperHero?)
    func error(error:String)
}
