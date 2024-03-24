//
//  EnemiesViewController.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by zhing on 24/3/24.
//

import UIKit

class EnemiesViewController: UIViewController {

    weak var delegate: ComponentSelectDelegate?

    @IBAction private func snailButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .enemy(.normal))
    }

    @IBAction private func stationaryButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .enemy(.stationary))
    }

    @IBAction private func birdButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .enemy(.fast))
    }

}
