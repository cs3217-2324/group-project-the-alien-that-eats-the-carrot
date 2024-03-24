//
//  PowerupsViewController.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by zhing on 24/3/24.
//

import UIKit

class PowerupsViewController: UIViewController {

    weak var delegate: ComponentSelectDelegate?

    @IBAction func powerUpUnusedButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .powerup(.attack))
    }

    @IBAction func powerupAttackButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .powerup(.attack))
    }

    @IBAction func powerupDoubleJumpButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .powerup(.doubleJump))
    }

    @IBAction func powerupInvincibilityButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .powerup(.invinsible))
    }

    @IBAction func powerupStrengthButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .powerup(.strength))
    }

}
