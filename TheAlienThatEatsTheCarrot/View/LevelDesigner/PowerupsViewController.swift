//
//  PowerupsViewController.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by zhing on 24/3/24.
//

import UIKit

class PowerupsViewController: UIViewController {

    weak var delegate: ComponentSelectDelegate?

    @IBAction private func powerupAttackButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .block(.attackPowerup))
    }

    @IBAction private func powerupDoubleJumpButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .block(.doubleJumpPowerup))
    }

    @IBAction private func powerupInvincibilityButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .block(.invinciblePowerup))
    }

    @IBAction private func powerupStrengthButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .block(.strengthPowerup))
    }

}
