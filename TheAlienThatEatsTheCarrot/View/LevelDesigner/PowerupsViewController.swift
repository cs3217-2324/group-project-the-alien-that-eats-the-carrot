//
//  PowerupsViewController.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by zhing on 24/3/24.
//

import UIKit

class PowerupsViewController: UIViewController {

    weak var delegate: ComponentSelectDelegate?

    @IBAction private func powerUpUnusedButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .powerup(.attack))
    }

    @IBAction private func powerupAttackButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .powerup(.attack))
    }

    @IBAction private func powerupDoubleJumpButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .powerup(.doubleJump))
    }

    @IBAction private func powerupInvincibilityButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .powerup(.invinsible))
    }

    @IBAction private func powerupStrengthButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .powerup(.strength))
    }

}
