//
//  AttackPowerupFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 10/4/24.
//

import Foundation

class AttackPowerupFactory: PowerupFactory {
    static let COOLDOWN_DURATION = 2.0
    override func createComponents() -> [Component] {
        let size = CGSize(width: boardObject.width, height: boardObject.height)
        let powerupComponent = PowerupComponent(entity: entity,
                                                powerupType: .attack)
        let renderableComponent = RenderableComponent(entity: entity,
                                                      position: boardObject.position,
                                                      objectType: .powerup(.attack),
                                                      size: size)
        let physicsBody = PhysicsBody(shape: .rectangle, position: boardObject.position, size: size,
                                      categoryBitmask: Constants.powerupCategoryBitmask,
                                      collisionBitmask: Constants.powerupCollisionBitmask,
                                      isDynamic: false)
        let physicsComponent = PhysicsComponent(entity: entity, physicsBody: physicsBody, disableGravity: true)
        let dissapearWhenCollideWith: [Component.Type] = [EnemyComponent.self, BlockComponent.self]
        let attackStyle = PeriodicallyShootPelletAttackStyle(targetables: [EnemyComponent.self],
                                                             directions: [.right],
                                                             dissapearWhenCollideWith: dissapearWhenCollideWith, cooldownDuration: AttackPowerupFactory.COOLDOWN_DURATION)
        let attackPowerupEffect = AttackPowerupEffect(attackStyle: attackStyle)
        let collisionEffectComponent = CollisionEffectComponent(entity: entity,
                                                                acceptableComponentsColliders: [PlayerComponent.self],
                                                                acceptableDirectionsToCollideFrom: [.up, .down, .left, .right],
                                                                collisionEffect: attackPowerupEffect)

        return [powerupComponent, renderableComponent, physicsComponent, collisionEffectComponent]
    }
}
