//
//  TimerSystem.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

class TimerSystem: System {
    var nexus: Nexus
    weak var gameEngine: GameEngine?

    init(nexus: Nexus, gameEngine: GameEngine?) {
        self.nexus = nexus
        self.gameEngine = gameEngine
    }

    func update(deltaTime: CGFloat) {
        let timerComponents = nexus.getComponents(of: TimerComponent.self)
        for timerComponent in timerComponents {
            if gameEngine?.getGameState() == .ongoing
                && timerComponent.timeElapsed >= timerComponent.duration {
                EventManager.shared.postEvent(timerComponent.event)
                nexus.removeComponent(timerComponent, from: timerComponent.entity)
            } else {
                timerComponent.timeElapsed += deltaTime
            }
        }
    }
}
