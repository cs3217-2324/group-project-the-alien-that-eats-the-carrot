//
//  GameRenderer.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 15/3/24.
//

import Foundation
import QuartzCore

class GameLoop {
    private var displayLink: CADisplayLink?
    var gameEngine: GameEngine

    init(gameEngine: GameEngine) {
        self.gameEngine = gameEngine
    }

    func start() {
        self.displayLink = createDisplayLink()
    }

    func stop() {
        displayLink?.remove(from: .main, forMode: .default)
        displayLink?.invalidate()
    }

    private func createDisplayLink() -> CADisplayLink {
        let displaylink = CADisplayLink(target: self,
                                        selector: #selector(step))
        displaylink.add(to: .current, forMode: .default)
        return displaylink
    }

    @objc func step(displaylink: CADisplayLink) {
        let timeInterval = displaylink.targetTimestamp - displaylink.timestamp
        gameEngine.update(deltaTime: timeInterval)
    }
}
