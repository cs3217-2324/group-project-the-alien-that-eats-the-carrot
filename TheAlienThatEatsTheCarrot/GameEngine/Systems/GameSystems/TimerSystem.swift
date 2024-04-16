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

    init(nexus: Nexus) {
        self.nexus = nexus
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
