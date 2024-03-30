//
//  MovableComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 15/3/24.
//

import Foundation

class MovableComponent: Component {
    var entity: Entity
    var pattern: MovementPattern

    init(entity: Entity, pattern: MovementPattern = LeftRightPattern()) {
        self.entity = entity
        self.pattern = pattern
    }

    func moveBasedOnPattern(deltaTime: CGFloat, delegate: MovableDelegate) {
        pattern.move(deltaTime: deltaTime, entity: entity, delegate: delegate)
    }
}
