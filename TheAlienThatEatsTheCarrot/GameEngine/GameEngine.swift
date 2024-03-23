//
//  GameEngine.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 11/3/24.
//

import CoreGraphics
import Combine

class GameEngine {
    let nexus = Nexus()
    var systems: [System]

    init() {
        self.systems = []
        initGameSystems()
        initGameEntities()
    }

    func update(deltaTime: CGFloat) {
        updateSystems(deltaTime: deltaTime)
    }

    private func updateSystems(deltaTime: CGFloat) {
        systems.forEach { $0.update(deltaTime: deltaTime) }
    }

    private func initGameSystems() {
        self.systems.append(contentsOf: [MovementSystem(nexus: nexus)])
    }

    private func initGameEntities() {
        nexus.addCharacterForPlayerA()
    }
}
