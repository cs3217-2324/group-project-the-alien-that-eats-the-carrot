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
                distance: movableComponent.distance,
                deltaTime: deltaTime
            )

            positionalComponent.position = newPosition
        }
    }

    private func calculateNewPosition(currentPosition: CGPoint, direction: Direction, distance: CGFloat, deltaTime: CGFloat) -> CGPoint {
        let angle = direction.radians
        let dx = cos(angle) * distance * deltaTime
        let dy = sin(angle) * distance * deltaTime
        return CGPoint(
            x: currentPosition.x + dx,
            y: currentPosition.y + dy
        )
    }
}
