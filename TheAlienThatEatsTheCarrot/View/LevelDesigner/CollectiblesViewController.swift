//
//  CollectiblesViewController.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by zhing on 24/3/24.
//

import UIKit

class CollectiblesViewController: UIViewController {

    weak var delegate: ComponentSelectDelegate?

    @IBAction private func carrotButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .collectable(.carrot))
    }

    @IBAction private func coinGoldButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .collectable(.coinGold))
    }

    @IBAction private func coinSilverButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .collectable(.coinSilver))
    }

    @IBAction private func coinBronzeButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .collectable(.coinBronze))
    }

    @IBAction private func heartButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .collectable(.heart))
    }

}
