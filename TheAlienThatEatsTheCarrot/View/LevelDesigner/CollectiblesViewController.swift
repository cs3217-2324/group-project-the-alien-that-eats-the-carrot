//
//  CollectiblesViewController.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by zhing on 24/3/24.
//

import UIKit

class CollectiblesViewController: UIViewController {

    weak var delegate: ComponentSelectDelegate?

    @IBAction func carrotButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .collectable(.carrot))
    }

    @IBAction func coinGoldButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .collectable(.coin))
    }

    @IBAction func coinSilverButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .collectable(.coin))
    }

    @IBAction func coinBronzeButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .collectable(.coin))
    }

    @IBAction func heartButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .collectable(.heart))
    }

}
