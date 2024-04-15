//
//  GameEndSystem.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 15/4/24.
//

import Foundation

class GameEndSystem: System {
    var nexus: Nexus
    weak var gameEngine: GameEngine?
    weak var gameEndObserver: NSObjectProtocol?

    init(nexus: Nexus, gameEngine: GameEngine?) {
        self.nexus = nexus
        self.gameEngine = gameEngine
        subscribeToEvents()
    }

    func subscribeToEvents() {
        gameEndObserver = EventManager.shared.subscribe(to: GameEndEvent.self, using: onGameEnd)
    }

    private lazy var onGameEnd = { [weak self] (event: Event) -> Void in
        guard let strongSelf = self,
              let gameEndEvent = event as? GameEndEvent else {
            return
        }
        strongSelf.gameEngine?.end()
    }

    func update(deltaTime: CGFloat) {
        checkWinCondition()
        checkLoseCondition()
    }

    private func checkWinCondition() {
        if checkThreeCarrotsCollected() {
            EventManager.shared.postEvent(GameEndEvent(isWin: true))
        }
    }

    private func checkThreeCarrotsCollected() -> Bool {
        guard let carrotsCollected = self.gameEngine?.gameStats.carrots else {
            return false
        }
        return carrotsCollected == 3
    }

    private func checkLoseCondition() {
        if !checkWhetherStillHaveLives(gameStat: self.gameEngine?.gameStats) {
            EventManager.shared.postEvent(GameEndEvent(isWin: false))
        }
    }

    private func checkWhetherStillHaveLives(gameStat: GameStats?) -> Bool {
        guard let lifeRemaining = gameStat?.lives[0] else {
            return true
        }
        return lifeRemaining > 0
    }
}
