//
//  StrengthPowerupFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

class StrengthPowerupFactory: PowerupFactory {
    override func createComponents() -> [Component] {
        let size = CGSize(width: boardObject.width, height: boardObject.height)
        let powerupComponent = PowerupComponent(entity: entity,
                                                powerup: StrengthGamePowerup(),
                                                powerupType: .strength)
        let renderableComponent = RenderableComponent(entity: entity,
                                                      position: boardObject.position,
                                                      objectType: .powerup(.strength),
                                                      size: size)
        let physicsBody = PhysicsBody(shape: .rectangle, position: boardObject.position, size: size,
                                      categoryBitmask: Constants.powerupCategoryBitmask,
                                      collisionBitmask: Constants.powerupCollisionBitmask,
                                      isDynamic: false)
        let physicsComponent = PhysicsComponent(entity: entity, physicsBody: physicsBody, disableGravity: true)
        let strengthPowerupEffect = StrengthPowerupEffect()
        let collisionEffectComponent = CollisionEffectComponent(entity: entity,
                                                                acceptableComponentsColliders: [PlayerComponent.self],
                                                                acceptableDirectionsToCollideFrom: [.up, .down, .left, .right],
                                                                collisionEffect: strengthPowerupEffect)
        return [powerupComponent, renderableComponent, physicsComponent, collisionEffectComponent]
    }
}
