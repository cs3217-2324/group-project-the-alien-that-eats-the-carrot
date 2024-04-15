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
    weak var characterHitExitBlockObserver: NSObjectProtocol?

    init(nexus: Nexus, gameEngine: GameEngine?) {
        self.nexus = nexus
        self.gameEngine = gameEngine
        subscribeToEvents()
    }

    func subscribeToEvents() {
        gameEndObserver = EventManager.shared.subscribe(to: GameEndEvent.self, using: onGameEnd)
        characterHitExitBlockObserver = EventManager.shared.subscribe(to: CharacterHitExitBlockEvent.self, using: onCharacterHitExitBlockObserver)
    }

    private lazy var onCharacterHitExitBlockObserver = { [weak self] (event: Event) -> Void in
        guard let strongSelf = self,
              let characterHitExitBlockEvent = event as? CharacterHitExitBlockEvent,
              let gameMode = strongSelf.gameEngine?.gameMode else {
            return
        }
        switch gameMode {
        case .normal:
            EventManager.shared.postEvent(GameEndEvent(isWin: true))
        }
    }

    private lazy var onGameEnd = { [weak self] (event: Event) -> Void in
        guard let strongSelf = self,
              let gameEndEvent = event as? GameEndEvent else {
            return
        }
        strongSelf.gameEngine?.end()
    }

    func update(deltaTime: CGFloat) {
        guard let gameMode = self.gameEngine?.gameMode else {
            return
        }
        switch gameMode {
        case .normal:
            checkNormalModeWinCondition()
            checkNormalModeLoseCondition()
        }
    }

    private func checkNormalModeWinCondition() {
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

    private func checkNormalModeLoseCondition() {
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
