//
//  TerrainsViewController.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by zhing on 24/3/24.
//

import UIKit

class TerrainsViewController: UIViewController {

    weak var delegate: ComponentSelectDelegate?

    @IBAction private func landBottomButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .block(.ground))
    }

    @IBAction private func landTopButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .block(.normal))
    }

    @IBAction private func blockBreakableButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .block(.breakable))
    }

    @IBAction private func blockUnreakableButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .block(.breakable))
    }

    @IBAction private func blockPushableButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .block(.pushable))
    }

    @IBAction private func rollerButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .block(.roller))
    }

    @IBAction private func platformSolidButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .block(.normal))
    }

    @IBAction private func mushroomButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .block(.mushroom))
    }

    @IBAction private func spikeButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .block(.spike))
    }
}
