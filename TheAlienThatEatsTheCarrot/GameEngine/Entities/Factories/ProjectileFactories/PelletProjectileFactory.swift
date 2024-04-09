//
//  PelletProjectileFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 10/4/24.
//

import Foundation

class PelletProjectileFactory: ProjectileFactory {
    override func createComponents() -> [Component] {
        let position = physicsBody.position
        let physicsComponent = PhysicsComponent(entity: entity, physicsBody: physicsBody)
        let renderableComponent = RenderableComponent(entity: entity, position: position, objectType: .projectile(.pellet))
        return [physicsComponent, renderableComponent]
    }
}
