//
//  TimerSystem.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

class TimerSystem: System {
    var nexus: Nexus
    private var gameEndObserver: NSObjectProtocol?
    weak var gameEngine: GameEngine?

    init(nexus: Nexus, gameEngine: GameEngine?) {
        self.nexus = nexus
        self.gameEngine = gameEngine
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
        let timerComponents = nexus.getComponents(of: TimerComponent.self)
        let gameStateComponent = nexus.getComponent(of: GameStateComponent.self)
        if gameStateComponent?.gameState != .ongoing {
            return
        }

        for timerComponent in timerComponents {
            if timerComponent.timeElapsed >= timerComponent.duration {
                EventManager.shared.postEvent(timerComponent.event)
                nexus.removeComponent(timerComponent, from: timerComponent.entity)
            } else {
                timerComponent.timeElapsed += deltaTime
            }
        }
    }
}
