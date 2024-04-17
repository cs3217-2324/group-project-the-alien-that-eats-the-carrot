//
//  LeftRightPattern.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

class LeftRightPattern: MovementPattern {
    static let DEFAULT_DISTANCE: CGFloat = 40.0
    static let DEFAULT_VELOCITY = CGVector(dx: 20.0, dy: 0)
    var velocity: CGVector
    var totalDistanceToMoveBeforeChange: CGFloat
    var distanceMoved: CGFloat = 0

    init(totalDistanceToMoveBeforeChange: CGFloat = LeftRightPattern.DEFAULT_DISTANCE,
         velocity: CGVector = LeftRightPattern.DEFAULT_VELOCITY) {
        self.totalDistanceToMoveBeforeChange = totalDistanceToMoveBeforeChange
        self.velocity = velocity
    }

    func move(deltaTime: CGFloat, entity: Entity, delegate: MovableDelegate) {
        guard
            let physicsComponent = delegate.getComponent(of: PhysicsComponent.self, for: entity) else {
            return
        }
        if distanceMoved >= totalDistanceToMoveBeforeChange {
            changeXDirection()
            distanceMoved = 0
            return
        }
        let horizontalDistanceMoved = velocity.magnitude * deltaTime
        physicsComponent.physicsBody.velocity = velocity
        distanceMoved += horizontalDistanceMoved
    }

    private func changeXDirection() {
        self.velocity.dx *= -1
    }
}
