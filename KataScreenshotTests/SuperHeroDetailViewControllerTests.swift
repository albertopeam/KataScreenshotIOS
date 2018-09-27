//
//  SuperHeroDetailViewControllerTests.swift
//  KataScreenshotTests
//
//  Created by Alberto on 27/9/18.
//  Copyright © 2018 Karumi. All rights reserved.
//

import XCTest
@testable import KataScreenshot

class SuperHeroDetailViewControllerTests: ScreenshotTest {
    
    fileprivate let repository = MockSuperHeroesRepository()
    
    override func setUp() {
        super.setUp()
        Constants.runningUITests = true
    }
    
    override func tearDown() {
        super.tearDown()
        Constants.runningUITests = false
    }
    
    // Spec 1. regular super hero
    func test_given_one_hero_when_didload_then_verify_screenshot() {
        let superHero = givenASuperHeroWithName()
        
        let viewController = openSuperHeroDetailViewController(superHero.name)
        
        verify(viewController: viewController)
    }
    
    // Spec 2. avenger super hero
    func test_given_one_avenger_when_didload_then_verify_screenshot() {
        let superHero = givenASuperHeroWithName(true)
        
        let viewController = openSuperHeroDetailViewController(superHero.name)
        
        verify(viewController: viewController)
    }
    
    // Spec 3. any superhero with long name
    func test_given_one_hero_with_long_name_when_didload_then_verify_screenshot() {
        let superHero = givenASuperHeroWithName(name: "Long name with some long long long long long long long long surnames")
        
        let viewController = openSuperHeroDetailViewController(superHero.name)
        
        verify(viewController: viewController)
    }
    
    // Spec 4. any superhero with long desc
    func test_given_one_hero_with_long_desc_when_didload_then_verify_screenshot() {
        let superHero = givenASuperHeroWithName(description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent mattis lorem id libero tempus, ac feugiat nisl sodales. Aliquam finibus quam lorem, eu iaculis nulla sollicitudin in. Etiam dui elit, aliquam ut hendrerit vel, cursus sit amet nunc. Sed nulla odio, ultrices nec erat eu, viverra vestibulum diam. Etiam vitae pharetra risus, et accumsan urna. Cras aliquet lectus vitae risus ultricies molestie. Ut imperdiet eros in erat pulvinar mattis. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec id aliquet metus, vitae facilisis velit. Vivamus risus quam, cursus nec nisl vitae, fringilla vehicula neque. Vivamus tristique aliquet facilisis. Sed dictum nisi ligula, sed porta ipsum sagittis eu. Vestibulum tristique purus libero, vel lobortis mi tristique eget. Donec sodales lobortis risus, vel vulputate mi ultricies sit amet. Vestibulum rutrum massa odio, et eleifend metus congue eu. Vivamus scelerisque, neque nec lacinia vulputate, eros est vestibulum tellus, vitae aliquet odio enim sit amet lacus. Nulla hendrerit scelerisque libero, quis viverra lorem interdum aliquam. In lorem erat, ullamcorper malesuada dolor sit amet, tempus bibendum ante. Nullam ultrices dictum eleifend. Etiam auctor, orci ac maximus bibendum, nunc justo volutpat nibh, eget suscipit felis arcu a ligula. Phasellus molestie lacus elementum eleifend imperdiet. In hac habitasse platea dictumst. In faucibus purus tincidunt iaculis congue. Cras ultricies dolor at scelerisque pulvinar. Proin et porttitor odio. Integer at ex non sapien pulvinar bibendum. In et ipsum fringilla, gravida libero nec, consectetur magna. Sed varius dolor mauris, convallis mattis purus vehicula molestie. Sed venenatis nisl ut suscipit efficitur.")
        
        let viewController = openSuperHeroDetailViewController(superHero.name)
        
        verify(viewController: viewController)
    }
    
    // Spec 5. any superhero without long name
    func test_given_one_hero_without_name_when_didload_then_verify_screenshot() {
        let superHero = givenASuperHeroWithName(name: "")
        
        let viewController = openSuperHeroDetailViewController(superHero.name)
        
        verify(viewController: viewController)
    }
    
    // Spec 6. any superhero without long desc
    func test_given_one_hero_without_desc_when_didload_then_verify_screenshot() {
        let superHero = givenASuperHeroWithName(description: "")
        
        let viewController = openSuperHeroDetailViewController(superHero.name)
        
        verify(viewController: viewController)
    }
    
    // PRAGMA: private
    
    fileprivate func givenASuperHeroWithName(name: String? = nil, description: String? = nil, _ isAvenger: Bool = false) -> SuperHero {
        let superHero = SuperHero(name: name ?? "Mr. Clean",
                                  photo: URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/c/60/55b6a28ef24fa.jpg"),
                                  isAvenger: isAvenger,
                                  description: description ?? "Description")
        repository.superHeroes = [superHero]
        return superHero
    }
    
    fileprivate func openSuperHeroDetailViewController(_ superHeroName: String) -> SuperHeroDetailViewController{
        let superHeroDetailViewController = ServiceLocator()
            .provideSuperHeroDetailViewController(superHeroName) as! SuperHeroDetailViewController
        superHeroDetailViewController.presenter = SuperHeroDetailPresenter(ui: superHeroDetailViewController,
                                                                           superHeroName: superHeroName,
                                                                           getSuperHeroByName: GetSuperHeroByName(repository: repository))
        let rootViewController = UINavigationController()
        rootViewController.viewControllers = [superHeroDetailViewController]
        
        return superHeroDetailViewController
    }
}
