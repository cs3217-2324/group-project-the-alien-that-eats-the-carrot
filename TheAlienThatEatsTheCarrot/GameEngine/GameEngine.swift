//
//  GameEngine.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 11/3/24.
//

import CoreGraphics
import Combine

class GameEngine {
    // ECS
    let nexus = Nexus()
    let systems: [System]

    init() {
        self.systems = []
        initGameEntities()
    }

    func update(deltaTime: CGFloat) {
        updateSystems(deltaTime: deltaTime)
    }
    
    private func updateSystems(deltaTime: CGFloat) {
        systems.forEach { $0.update(deltaTime: deltaTime) }
    }
    
    private func initGameEntities() {
        nexus.addCharacter()
    }
}
