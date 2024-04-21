//
//  LevelView.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by zhing on 22/3/24.
//

import UIKit
import AVFoundation

protocol LevelViewDelegate: AnyObject {
    func playButtonTapped(for levelName: String)
}

class LevelView: UIView {
    weak var delegate: LevelViewDelegate?

    @IBOutlet private var levelNameText: UILabel!
    @IBOutlet private var carrot1: UIImageView!
    @IBOutlet private var carrot2: UIImageView!
    @IBOutlet private var carrot3: UIImageView!
    @IBOutlet private var bestScoreText: UILabel!
    @IBOutlet private var bestTimeText: UILabel!

    // Function to configure the level view with data
    func configure(levelName: String, score: Int, carrot: Int, time: Int) {
        levelNameText.text = levelName
        updateScore(score)
        updateTimer(time)
        updateCarrotCount(carrot)
    }

    @IBAction private func playButtonTapped(_ sender: UIButton) {
        delegate?.playButtonTapped(for: levelNameText.text ?? "")
    }

    private func updateScore(_ score: Int) {
        if score == 0 {
            bestScoreText.text = "SCORE: -"
        } else {
            bestScoreText.text = "SCORE: \(String(score))"
        }
    }

    private func updateTimer(_ time: Int) {
        if time == 0 {
            bestTimeText.text = "TIME: -"
        } else {
            let totalseconds = time / 60
            let minutes = totalseconds / 60
            let seconds = totalseconds % 60
            let formattedTime = String(format: "TIME: %d : %02d", minutes, seconds)
            bestTimeText.text = formattedTime
        }
    }

    private func updateCarrotCount(_ number: Int) {
        let fullCarrot = #imageLiteral(resourceName: "carrot-1")
        let emptyCarrot = #imageLiteral(resourceName: "carrot-2")

        carrot1.image = number > 0 ? fullCarrot : emptyCarrot
        carrot2.image = number > 1 ? fullCarrot : emptyCarrot
        carrot3.image = number > 2 ? fullCarrot : emptyCarrot
    }

}
