//
//  GameOverViewController.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by zhing on 17/4/24.
//

import UIKit

protocol GameOverReplayDelegate: AnyObject {
    func replayGameFromGameOver()
}

class GameOverViewController: UIViewController {
    weak var delegate: GameOverReplayDelegate?

   @IBAction private func replayButtonTapped(_ sender: UIButton) {
       delegate?.replayGameFromGameOver()
       dismiss(animated: true, completion: nil)
   }
}
