//
//  SuperHeroDetailViewController.swift
//  KataSuperHeroes
//
//  Created by Pedro Vicente Gomez on 12/01/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import Foundation
import UIKit
import BothamUI
import SDWebImage

class SuperHeroDetailViewController: KataSuperHeroesViewController, SuperHeroDetailUI {
    
    @IBOutlet weak var avengersBadgeImageView: UIImageView!

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    func show(superHero: SuperHero?) {
        guard let superHero = superHero else {
            return
        }
        let name = superHero.isAvenger ? "\(superHero.name)-(AVENGER)":"\(superHero.name)"
        userLabel.text = name
        userLabel.accessibilityLabel = "Name: \(superHero.name)"
        userLabel.isHidden = false
        descriptionLabel.text = superHero.description
        descriptionLabel.accessibilityLabel = "Description: \(superHero.name)"
        descriptionLabel.isHidden = false
        if Constants.runningUITests {
            //TODO: pending
            photoImageView.image = UIImage(named: "")
        }else{
            photoImageView.sd_setImage(with: superHero.photo as URL!)
        }
        avengersBadgeImageView.isHidden = !superHero.isAvenger
        errorLabel.isHidden = true
        errorLabel.text = ""
    }
    
    func error(error: String) {
        errorLabel.text = error
        errorLabel.isHidden = false
    }
}
