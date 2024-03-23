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
    
    init(entity: Entity, physicsBody: PhysicsBody) {
        self.entity = entity
        self.physicsBody = physicsBody
    }
}
