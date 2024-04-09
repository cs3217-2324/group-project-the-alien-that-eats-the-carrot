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

    init(entity: Entity, physicsBody: PhysicsBody) {
        self.entity = entity
        self.physicsBody = physicsBody
    }

    func createComponents() -> [Component] {
        []
    }
}
