//
//  ProjectileFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 10/4/24.
//

import Foundation

class ProjectileFactory: EntityFactory {
    var entity: Entity
    let physicsBody: PhysicsBody
    var targetables: [Component.Type]

    init(entity: Entity, physicsBody: PhysicsBody, targetables: [Component.Type]) {
        self.entity = entity
        self.physicsBody = physicsBody
        self.targetables = targetables
    }

    func createComponents() -> [Component] {
        []
    }
}
