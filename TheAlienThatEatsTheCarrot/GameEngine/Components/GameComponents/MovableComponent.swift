//
//  MovableComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 15/3/24.
//

import Foundation

class MovableComponent: Component {
    static let DEFAULT_DISTANCE: CGFloat = 100.0
    var entity: Entity
    var velocity: CGVector
    var movementPattern: MovementPattern
    var totalDistanceToMoveBeforeChange: CGFloat
    var distanceMoved: CGFloat = 0

    init(entity: Entity, velocity: CGVector, movementPattern: MovementPattern, totalDistanceToMoveBeforeChange: CGFloat = MovableComponent.DEFAULT_DISTANCE) {
        self.entity = entity
        self.velocity = velocity
        self.movementPattern = movementPattern
        self.totalDistanceToMoveBeforeChange = totalDistanceToMoveBeforeChange
    }
}

enum MovementPattern {
    case upDown, leftRight
}
