//
//  StartScreenViewController.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by zhing on 15/3/24.
//

import UIKit
import AVFoundation

class StartScreenViewController: UIViewController {
    
    @IBOutlet private var levelSelectButton: UIButton!
    @IBOutlet private var levelDesignerButton: UIButton!
    @IBOutlet private var multiplayerButton: UIButton!

    @IBAction private func levelSelectButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "LevelSelectSegue", sender: nil)
    }
    
    @IBAction private func levelDesignerButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "LevelDesignerSegue", sender: nil)
    }
    
    @IBAction func multiplayerButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "MultiplayerLevelSelectSegue", sender: nil)
    }
}
