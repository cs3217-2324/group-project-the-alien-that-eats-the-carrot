//
//  PositionalSystem.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 2/4/24.
//

import Foundation

class PositionalSystem: System {
    var nexus: Nexus

    init(nexus: Nexus) {
        self.nexus = nexus
    }

    func update(deltaTime: CGFloat) {
        let physicsComponents = nexus.getComponents(of: PhysicsComponent.self)
        for physicsComponent in physicsComponents {
            physicsComponent.physicsBody.position += physicsComponent.physicsBody.velocity
            guard let renderableComponent = nexus.getComponent(of: RenderableComponent.self, for: physicsComponent.entity) else {
                return
            }
            renderableComponent.position = physicsComponent.physicsBody.position
        }
    }
}
