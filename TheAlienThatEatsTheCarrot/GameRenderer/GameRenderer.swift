//
//  GameRenderer.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 15/3/24.
//

import Foundation
import QuartzCore

class GameRenderer {
    private var displayLink: CADisplayLink?
    var gameEngine: GameEngine?

    func start() {
        self.displayLink = createDisplayLink()
    }

    func stop() {
        displayLink?.remove(from: .main, forMode: .default)
        displayLink?.invalidate()
    }

    func createDisplayLink() -> CADisplayLink {
        let displaylink = CADisplayLink(target: self,
                                        selector: #selector(step))
        displaylink.add(to: .current, forMode: .default)
        return displaylink
    }

    @objc func step(displaylink: CADisplayLink) {
        if gameEngine == nil {
            return
        }
        let timeInterval = displaylink.targetTimestamp - displaylink.timestamp
        print("\(timeInterval)")
        gameEngine?.update(deltaTime: timeInterval)
    }
}
