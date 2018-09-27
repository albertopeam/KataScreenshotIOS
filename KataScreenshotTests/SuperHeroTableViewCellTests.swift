//
//  SuperHeroTableViewCellTests.swift
//  KataScreenshot
//
//  Created by Sergio Gutiérrez on 09/01/17.
//  Copyright © 2017 Karumi. All rights reserved.
//

import UIKit
import XCTest
@testable import KataScreenshot

class SuperHeroTableViewCellTests: ScreenshotTest {

    override func setUp() {
        super.setUp()
        Constants.runningUITests = true
    }
    
    override func tearDown() {
        super.tearDown()
        Constants.runningUITests = false
    }
    
    // Spec 1. show hero
    func test_given_hero_when_configure_then_verify_screenshot() {
        let hero = givenSuperHero()
        
        let cell = givenASuperHeroTableViewCell()
        cell.configure(forItem: hero)
        
        verify(view: cell)
    }
    
    // Spec 2. show hero with long name
    func test_given_hero_with_long_name_when_configure_then_verify_screenshot() {
        let hero = givenSuperHero(name: "A really long long long long long long long long long long name")
        
        let cell = givenASuperHeroTableViewCell()
        cell.configure(forItem: hero)
        
        verify(view: cell)
    }
    
    // Spec 3. show hero without name
    func test_given_hero_without_name_when_configure_then_verify_screenshot() {
        let hero = givenSuperHero(name: "")
        
        let cell = givenASuperHeroTableViewCell()
        cell.configure(forItem: hero)
        
        verify(view: cell)
    }
    
    // Spec 4. show hero without name
    func test_given_avenger_when_configure_then_verify_screenshot() {
        let hero = givenSuperHero(isAvenger: true)
        
        let cell = givenASuperHeroTableViewCell()
        cell.configure(forItem: hero)
        
        verify(view: cell)
    }
    
    // Spec 5. show hero with long name
    func test_given_avenger_with_long_name_when_configure_then_verify_screenshot() {
        let hero = givenSuperHero(name: "A really long long long long long long long long long long name", isAvenger: true)
        
        let cell = givenASuperHeroTableViewCell()
        cell.configure(forItem: hero)
        
        verify(view: cell)
    }
    
    // Spec 6. show hero without name
    func test_given_avenger_without_name_when_configure_then_verify_screenshot() {
        let hero = givenSuperHero(name: "", isAvenger: true)
        
        let cell = givenASuperHeroTableViewCell()
        cell.configure(forItem: hero)
        
        verify(view: cell)
    }
    
    // PRAGMA: private
    
    private func givenASuperHeroTableViewCell() -> SuperHeroTableViewCell {
        return UINib(nibName: "SuperHeroTableViewCell", bundle: Bundle.main).instantiate(withOwner: self, options: nil)[0] as! SuperHeroTableViewCell
    }
    
    private func givenSuperHero(name: String? = nil, isAvenger:Bool = false) -> SuperHero{
        return SuperHero(name: name ?? "Mr. Clean", photo: URL(string: ""), isAvenger: isAvenger, description: "Description")
    }
}
