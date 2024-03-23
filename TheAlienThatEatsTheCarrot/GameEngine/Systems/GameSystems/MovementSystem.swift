//
//  MovementSystems.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 15/3/24.
//

import Foundation

class MovementSystem: System {
    var nexus: Nexus

    init(nexus: Nexus) {
        self.nexus = nexus
    }

    func update(deltaTime: CGFloat) {
        let movableComponents = nexus.getComponents(of: MovableComponent.self)
        for movableComponent in movableComponents {
            let entity = movableComponent.entity
            guard let renderableComponent = nexus.getComponent(of: RenderableComponent.self, for: entity) else {
                return
            }
            let newPosition = calculateNewPosition(
                currentPosition: renderableComponent.position,
                velocity: movableComponent.velocity,
                deltaTime: deltaTime
            )

            renderableComponent.position = newPosition
        }
    }

    private func calculateNewPosition(currentPosition: CGPoint, velocity: CGVector, deltaTime: CGFloat) -> CGPoint {
        let dx = velocity.dx * deltaTime
        let dy = velocity.dy * deltaTime
        return CGPoint(
            x: currentPosition.x + dx,
            y: currentPosition.y + dy
        )
    }
}
