//
//  LeftRightPattern.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

class LeftRightPattern: MovementPattern {
    static let DEFAULT_DISTANCE: CGFloat = 200.0
    var totalDistanceToMoveBeforeChange: CGFloat
    var distanceMoved: CGFloat = 0

    init(totalDistanceToMoveBeforeChange: CGFloat = LeftRightPattern.DEFAULT_DISTANCE) {
        self.totalDistanceToMoveBeforeChange = totalDistanceToMoveBeforeChange
    }

    func move(deltaTime: CGFloat, entity: Entity, delegate: MovableDelegate) {
        guard
            let physicsComponent = delegate.getComponent(of: PhysicsComponent.self, for: entity) else {
            return
        }
        if distanceMoved >= totalDistanceToMoveBeforeChange {
            changeXDirectionFor(physicsComponent)
            distanceMoved = 0
            return
        }
        let horizontalDistanceMoved = physicsComponent.physicsBody.velocity.dx.magnitude * deltaTime
        distanceMoved += horizontalDistanceMoved
    }

    private func changeXDirectionFor(_ physicsComponent: PhysicsComponent) {
        physicsComponent.physicsBody.velocity.dx *= -1
    }
}
