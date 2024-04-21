//
//  InvinsiblePowerupFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

class InvinciblePowerupFactory: PowerupFactory {
    override func createComponents() -> [Component] {
        let size = CGSize(width: boardObject.width, height: boardObject.height)
        let powerupComponent = PowerupComponent(entity: entity,
                                                powerupType: .invinsible)
        let renderableComponent = RenderableComponent(entity: entity,
                                                      position: boardObject.position,
                                                      objectType: .powerup(.invinsible),
                                                      size: size)
        let physicsBody = PhysicsBody(shape: .rectangle, position: boardObject.position, size: size,
                                      categoryBitmask: Constants.powerupCategoryBitmask,
                                      collisionBitmask: Constants.powerupCollisionBitmask,
                                      isDynamic: false)
        let physicsComponent = PhysicsComponent(entity: entity, physicsBody: physicsBody, disableGravity: true)
        let invinciblePowerupEffect = InvinciblePowerupEffect()
        let collisionEffectComponent = CollisionEffectComponent(entity: entity,
                                                                acceptableComponentsColliders: [PlayerComponent.self, EnemyComponent.self],
                                                                acceptableDirectionsToCollideFrom: [.up, .down, .left, .right],
                                                                collisionEffect: invinciblePowerupEffect)
        return [powerupComponent, renderableComponent, collisionEffectComponent,
                physicsComponent]
    }
}
