//
//  PhysicsComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 23/3/24.
//

import Foundation

class PhysicsComponent: Component {
    var entity: Entity
    var physicsBody: PhysicsBody
    var disableGravity: Bool

    init(entity: Entity, physicsBody: PhysicsBody, disableGravity: Bool = false) {
        self.entity = entity
        self.physicsBody = physicsBody
        self.disableGravity = disableGravity
    }
}
