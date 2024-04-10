//
//  DoubleJumpPowerupFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 30/3/24.
//

import Foundation

class DoubleJumpPowerupFactory: PowerupFactory {
    override func createComponents() -> [Component] {
        let size = CGSize(width: boardObject.width, height: boardObject.height)
        let powerupComponent = PowerupComponent(entity: entity,
                                                powerupType: .doubleJump)
        let renderableComponent = RenderableComponent(entity: entity,
                                                      position: boardObject.position,
                                                      objectType: .powerup(.doubleJump),
                                                      size: size)
        let physicsBody = PhysicsBody(shape: .rectangle, position: boardObject.position, size: size,
                                      categoryBitmask: Constants.powerupCategoryBitmask,
                                      collisionBitmask: Constants.powerupCollisionBitmask,
                                      isDynamic: false)
        let physicsComponent = PhysicsComponent(entity: entity, physicsBody: physicsBody, disableGravity: true)
        let doubleJumpPowerupEffect = DoubleJumpPowerupEffect()
        let collisionEffectComponent = CollisionEffectComponent(entity: entity,
                                                                acceptableComponentsColliders: [PlayerComponent.self],
                                                                acceptableDirectionsToCollideFrom: [.up, .down, .left, .right],
                                                                collisionEffect: doubleJumpPowerupEffect)

        return [powerupComponent, renderableComponent, physicsComponent, collisionEffectComponent]
    }
}
