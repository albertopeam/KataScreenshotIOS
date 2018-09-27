//
//  SuperHeroesViewControllerTests.swift
//  KataSuperHeroes
//
//  Created by Sergio Gutiérrez on 22/12/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import UIKit
@testable import KataScreenshot

class SuperHeroesViewControllerTests: ScreenshotTest {

    fileprivate let repository = MockSuperHeroesRepository()
    
    override func setUp() {
        super.setUp()
        Constants.runningUITests = true
    }
    
    override func tearDown() {
        super.tearDown()
        Constants.runningUITests = false
    }

    // Spec 1. show when empty case
    func testShowsEmptyCase() {
        givenThereAreNoSuperHeroes()

        let viewController = getSuperHeroViewController()

        //WE CAN USE KIF
        verify(viewController: viewController)
    }
    
    // Spec 2. shows some super heroes
    func test_given_some_heroes_when_didload_then_verify_screenshot() {
        _ = givenThereAreSomeHeroes()
        
        let viewController = getSuperHeroViewController()
        
        //WE CAN USE KIF
        verify(viewController: viewController)
    }
    
    // Spec 3. shows an avenger
    func test_given_an_avenger_when_didload_then_verify_screenshot() {
        _ = givenThereAreSomeSuperHeroes(1, avengers: true)
        
        let viewController = getSuperHeroViewController()
        
        //WE CAN USE KIF
        verify(viewController: viewController)
    }
    
    // Spec 4. Shows a regular super hero
    func test_given_a_hero_when_didload_when_verify_screenshot() {
        _ = givenThereAreSomeSuperHeroes(1, avengers: false)
        
        let viewController = getSuperHeroViewController()
        
        //WE CAN USE KIF
        verify(viewController: viewController)
    }
    
    // Spec 5. Long names for a hero
    func test_given_a_hero_with_long_name_when_didload_when_verify_screenshot() {
        _ = givenThereAreSomeSuperHeroes(1, name: "Long name with some long long long long long long long long surnames", avengers: false)
        
        let viewController = getSuperHeroViewController()
        
        //WE CAN USE KIF
        verify(viewController: viewController)
    }
    
    // Spec 6. With an empty name
    func test_given_a_hero_with_empty_name_when_didload_when_verify_screenshot() {
        _ = givenThereAreSomeSuperHeroes(1, name: "", avengers: false)
        
        let viewController = getSuperHeroViewController()
        
        //WE CAN USE KIF
        verify(viewController: viewController)
    }
    
    // Spec 7. Long names for avenger
    func test_given_an_avenger_with_long_name_when_didload_when_verify_screenshot() {
        _ = givenThereAreSomeSuperHeroes(1, name: "Long name with some long long long long long long long long surnames", avengers: true)
        
        let viewController = getSuperHeroViewController()
        
        //WE CAN USE KIF
        verify(viewController: viewController)
    }
    
    // Spec 8. With an empty name for avenger
    func test_given_an_avenger_with_empty_name_when_didload_when_verify_screenshot() {
        _ = givenThereAreSomeSuperHeroes(1, name: "", avengers: true)
        
        let viewController = getSuperHeroViewController()
        
        //WE CAN USE KIF
        verify(viewController: viewController)
    }
    
    // Spec 9. Loading. animations in general is imposible to capture in same position. Disable animations y test. Se puede hacer con un if guarro para que no se anime el loading mezclando el código de producción+tests.
    
    // Spec 10. Images. Timing in loading, animations to present.

    fileprivate func givenThereAreSomeAvengers() -> [SuperHero] {
        return givenThereAreSomeSuperHeroes(avengers: true)
    }
    
    fileprivate func givenThereAreSomeHeroes() -> [SuperHero] {
        return givenThereAreSomeSuperHeroes(avengers: false)
    }

    fileprivate func givenThereAreNoSuperHeroes() {
        _ = givenThereAreSomeSuperHeroes(0)
    }

    fileprivate func givenThereAreSomeSuperHeroes(_ numberOfSuperHeroes: Int = 10,
                                                  name: String? = nil,
                                                avengers: Bool = false) -> [SuperHero] {
        var superHeroes = [SuperHero]()
        for i in 0..<numberOfSuperHeroes {
            let superHero = SuperHero(name: name ?? "SuperHero - \(i)",
                photo: URL(string: ""),
                isAvenger: avengers, description: "Description - \(i)")
            superHeroes.append(superHero)
        }
        repository.superHeroes = superHeroes
        return superHeroes
    }

    fileprivate func getSuperHeroViewController() -> UIViewController {
        let superHeroesViewController = ServiceLocator()
            .provideSuperHeroesViewController() as! SuperHeroesViewController
        superHeroesViewController.presenter = SuperHeroesPresenter(
            ui: superHeroesViewController,
            getSuperHeroes: GetSuperHeroes(repository: repository)
        )

        let rootViewController = UINavigationController()
        rootViewController.viewControllers = [superHeroesViewController]

        return rootViewController
    }
}
