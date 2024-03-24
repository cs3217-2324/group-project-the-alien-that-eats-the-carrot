//
//  TerrainsViewController.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by zhing on 24/3/24.
//

import UIKit

class TerrainsViewController: UIViewController {

    weak var delegate: ComponentSelectDelegate?

    @IBAction func landBottomButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .block(.ground))
    }

    @IBAction func landTopButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .block(.normal))
    }

    @IBAction func blockBreakableButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .block(.breakable))
    }

    @IBAction func blockUnreakableButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .block(.breakable))
    }

    @IBAction func blockPushableButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .block(.pushable))
    }

    @IBAction func platformOnewayButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .block(.normal))
    }

    @IBAction func platformSolidButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .block(.normal))
    }

    @IBAction func mushroomButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .block(.normal))
    }

    @IBAction func spikeButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(type: .block(.spike))
    }
}
