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
    var canBePushedBy: [Component.Type]
    var pushForceMagnitude: CGFloat

    init(canBePushedFrom: [Direction],
         canBePushedBy: [Component.Type],
         pushForceMagnitude: CGFloat = MoveWhenPushedPattern.DEFAULT_PUSH_FORCE_MAGNITUDE) {
        self.canBePushedFrom = canBePushedFrom
        self.canBePushedBy = canBePushedBy
        self.pushForceMagnitude = pushForceMagnitude
    }

    func move(deltaTime: CGFloat, entity: Entity, delegate: MovableDelegate) {
        guard let pusheePhysicsComponent = delegate.getComponent(of: PhysicsComponent.self, for: entity) else {
            return
        }
        let pusherPhysicsComponents = delegate.getComponents(of: PhysicsComponent.self)
        for pusherPhysicsComponent in pusherPhysicsComponents {
            guard
                delegate.containsAnyComponent(of: canBePushedBy, in: pusherPhysicsComponent.entity)
            else {
                return
            }
            for direction in canBePushedFrom
            where pusherPhysicsComponent.physicsBody.isCollidingWith(pusheePhysicsComponent.physicsBody, on: direction) {
                let forceVector = forceForDirection(direction)
                pusheePhysicsComponent.physicsBody.applyForce(forceVector)
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
