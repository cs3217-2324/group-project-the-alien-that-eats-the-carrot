//
//  RandomPattern.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 31/3/24.
//

import Foundation

/// Move for a fixed distance before changing to a random direction (up down left or right)
class RandomPattern: MovementPattern {
    static let DEFAULT_DISTANCE: CGFloat = 50.0
    static let SPEED_LOWER_BOUND: CGFloat = -50.0
    static let SPEED_UPPER_BOUND: CGFloat = 50.0
    var totalDistanceToMoveBeforeChange: CGFloat
    var distanceMoved: CGFloat = 0
    var currentVelocity: CGVector = .zero

    var speedLowerBound: CGFloat
    var speedUpperBound: CGFloat

    init(totalDistanceToMoveBeforeChange: CGFloat = RandomPattern.DEFAULT_DISTANCE,
         speedLowerBound: CGFloat = RandomPattern.SPEED_LOWER_BOUND,
         speedUpperBound: CGFloat = RandomPattern.SPEED_UPPER_BOUND) {
        self.totalDistanceToMoveBeforeChange = totalDistanceToMoveBeforeChange
        self.speedLowerBound = speedLowerBound
        self.speedUpperBound = speedUpperBound
    }

    func move(deltaTime: CGFloat, entity: Entity, delegate: MovableDelegate) {
        guard let physicsComponent = delegate.getComponent(of: PhysicsComponent.self, for: entity) else {
            return
        }

        let distanceMovedThisFrame = physicsComponent.physicsBody.velocity.magnitude * deltaTime
        distanceMoved += distanceMovedThisFrame

        if distanceMoved >= totalDistanceToMoveBeforeChange {
            currentVelocity = CGVector(dx: randomDirection(), dy: randomDirection())
            physicsComponent.physicsBody.velocity = currentVelocity
            distanceMoved = 0
        }
    }

    private func randomDirection() -> CGFloat {
        let speeds = [speedLowerBound, speedUpperBound]
        return CGFloat(speeds.randomElement()!)
    }
}
