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
            guard let positionalComponent = nexus.getComponent(of: PositionalComponent.self, for: entity) else {
                return
            }
            let newPosition = calculateNewPosition(
                currentPosition: positionalComponent.position,
                direction: movableComponent.direction,
                length: movableComponent.length,
                deltaTime: deltaTime
            )
            
            positionalComponent.position = newPosition
        }
    }

    private func calculateNewPosition(currentPosition: CGPoint, direction: Direction, length: CGFloat, deltaTime: CGFloat) -> CGPoint {
        let angle = direction.radians
        let dx = cos(angle) * length * deltaTime
        let dy = sin(angle) * length * deltaTime
        return CGPoint(
            x: currentPosition.x + dx,
            y: currentPosition.y + dy
        )
    }
}
