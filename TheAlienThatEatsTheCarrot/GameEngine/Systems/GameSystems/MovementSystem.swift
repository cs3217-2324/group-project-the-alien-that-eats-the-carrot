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
        for movable in movableComponents {
            updatePosition(for: movable, deltaTime: deltaTime)
        }
    }

    private func updatePosition(for movable: MovableComponent, deltaTime: CGFloat) {
        let entity = movable.entity
        guard let renderableComponent = nexus.getComponent(of: RenderableComponent.self, for: entity) else {
            return
        }

        let newPosition = calculateNewPosition(
            currentPosition: renderableComponent.position,
            velocity: movable.velocity,
            deltaTime: deltaTime
        )

        renderableComponent.position = newPosition
        handleMovementPattern(movable, newPosition: newPosition, deltaTime: deltaTime)
    }

    private func calculateNewPosition(currentPosition: CGPoint, velocity: CGVector, deltaTime: CGFloat) -> CGPoint {
        let dx = velocity.dx * deltaTime
        let dy = velocity.dy * deltaTime
        return CGPoint(
            x: currentPosition.x + dx,
            y: currentPosition.y + dy
        )
    }

    private func handleMovementPattern(_ movable: MovableComponent, newPosition: CGPoint, deltaTime: CGFloat) {
        movable.distanceMoved += movable.velocity.magnitude * deltaTime

        if movable.distanceMoved >= movable.totalDistanceToMoveBeforeChange {
            switch movable.movementPattern {
            case .leftRight:
                movable.velocity.dx *= -1
            case .upDown:
                movable.velocity.dy *= -1
                movable.distanceMoved = 0
            }
            movable.distanceMoved = 0
        }
    }
}
