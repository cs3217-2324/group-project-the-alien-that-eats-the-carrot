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
    var updateUI: (() -> Void)?

    init(gameEngine: GameEngine, updateUI: (() -> Void)? = nil) {
        self.gameEngine = gameEngine
        self.updateUI = updateUI
        gameEngine.gameLoop = self
    }

    func start() {
        self.displayLink = createDisplayLink()
    }

    func stop() {
        displayLink?.invalidate()
        displayLink = nil
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
        updateUI?()
    }
}
