//
//  MovableComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 15/3/24.
//

import Foundation

class MovableComponent: Component {
    var entity: Entity
    var velocity: CGVector

    init(entity: Entity, velocity: CGVector = .zero) {
        self.entity = entity
        self.velocity = velocity
    }
}
