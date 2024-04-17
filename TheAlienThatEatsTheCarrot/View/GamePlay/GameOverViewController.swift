//
//  GameOverViewController.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by zhing on 17/4/24.
//

import UIKit

protocol GameOverDelegate: AnyObject {
    func replayGame()
}

class GameOverViewController: UIViewController {
    weak var delegate: GameOverDelegate?

   @IBAction private func replayButtonTapped(_ sender: UIButton) {
       delegate?.replayGame()
       dismiss(animated: true, completion: nil)
   }
}
