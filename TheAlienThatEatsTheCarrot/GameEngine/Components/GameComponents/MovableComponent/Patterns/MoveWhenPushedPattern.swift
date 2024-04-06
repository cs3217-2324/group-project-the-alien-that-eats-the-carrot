//
//  MoveWhenPushedPattern.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 5/4/24.
//

import Foundation

class MoveWhenPushedPattern: MovementPattern {
    static let DEFAULT_PUSH_FORCE_MAGNITUDE = 2_000.0
    var canBePushedFrom: [Direction]
    var pushForceMagnitude: CGFloat

    init(canBePushedFrom: [Direction],
         pushForceMagnitude: CGFloat = MoveWhenPushedPattern.DEFAULT_PUSH_FORCE_MAGNITUDE) {
        self.canBePushedFrom = canBePushedFrom
        self.pushForceMagnitude = pushForceMagnitude
    }

    func move(deltaTime: CGFloat, entity: Entity, delegate: MovableDelegate) {
        guard let physicsComponent = delegate.getComponent(of: PhysicsComponent.self, for: entity) else {
            return
        }
        let playerComponents = delegate.getComponents(of: PlayerComponent.self)
        for playerComponent in playerComponents {
            guard let playerPhysicsComponent = delegate.getComponent(of: PhysicsComponent.self, for: playerComponent.entity) else {
                continue
            }
            for direction in canBePushedFrom
            where playerPhysicsComponent.physicsBody.isCollidingWith(physicsComponent.physicsBody, on: direction) {
                let forceVector = forceForDirection(direction)
                physicsComponent.physicsBody.applyForce(forceVector)
            }
        }
    }

    private func forceForDirection(_ direction: Direction) -> CGVector {
        switch direction {
        case .left:
            return CGVector(dx: pushForceMagnitude, dy: 0)
        case .right:
            return CGVector(dx: -pushForceMagnitude, dy: 0)
        case .up:
            return CGVector(dx: 0, dy: -pushForceMagnitude)
        case .down:
            return CGVector(dx: 0, dy: pushForceMagnitude)
        }
    }
}
