//
//  LevelClearedViewController.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by zhing on 17/4/24.
//

import UIKit

protocol GameClearReplayDelegate: AnyObject {
    func replayGameFromGameClear()
}

class LevelClearedViewController: UIViewController {

    @IBOutlet private var carrot1: UIImageView!
    @IBOutlet private var carrot2: UIImageView!
    @IBOutlet private var carrot3: UIImageView!
    @IBOutlet private var coinCountText: UILabel!
    @IBOutlet private var scoreText: UILabel!
    @IBOutlet private var timeText: UILabel!
    var gameStats: GameStats!
    weak var delegate: GameClearReplayDelegate?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateCoinCount(gameStats.coins)
        updateCarrotCount(gameStats.carrots)
        updateScore(gameStats.score)

//        updateTimer(remainingTime: gameStats.time)
        updateTimer(time: 5_557)
    }

    private func updateCoinCount(_ count: Int) {
        coinCountText.text = String(count)
    }

    private func updateCarrotCount(_ number: Int) {
        let fullCarrot = #imageLiteral(resourceName: "carrot-1")
        let emptyCarrot = #imageLiteral(resourceName: "carrot-2")

        carrot1.image = number > 0 ? fullCarrot : emptyCarrot
        carrot2.image = number > 1 ? fullCarrot : emptyCarrot
        carrot3.image = number > 2 ? fullCarrot : emptyCarrot
    }

    private func updateScore(_ count: Int) {
        scoreText.text = "SCORE: \(String(count))"
    }

    private func updateTimer(time: Int) {
        let totalseconds = time / 60
        let minutes = totalseconds / 60
        let seconds = totalseconds % 60
        let formattedTime = String(format: "TIME: %d : %02d", minutes, seconds)
        timeText.text = formattedTime
    }

    @IBAction private func replayButtonTapped(_ sender: UIButton) {
        delegate?.replayGameFromGameClear()
        dismiss(animated: true, completion: nil)
    }
}
