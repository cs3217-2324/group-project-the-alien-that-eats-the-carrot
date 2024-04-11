//
//  PelletProjectileFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 10/4/24.
//

import Foundation

class PelletProjectileFactory: ProjectileFactory {
    override func createComponents() -> [Component] {
        let physicsBody = PhysicsBody(shape: .circle, position: position, size: size,
                                      categoryBitmask: Constants.projectileCategoryBitmask,
                                      collisionBitmask: Constants.projectileCollisionBitmask,
                                      isDynamic: true, velocity: velocity)
        let physicsComponent = PhysicsComponent(entity: entity, physicsBody: physicsBody)
        let renderableComponent = RenderableComponent(entity: entity, position: position, objectType: .projectile(.pellet))
        let meleeAttackStyle = MeleeAttackStyle(targetables: targetables,
                                                acceptableAttackDirections: [.up, .down, .left, .right],
                                                knockbackStrength: 0)
        let attackableComponent = AttackableComponent(entity: entity, attackStyles: [meleeAttackStyle])
        // projectile to be removed either its lifespan has expired or it collides with something
        let removeEntityEvent = RemoveEntityEvent(entity: entity)
        let timerComponent = TimerComponent(entity: entity, duration: lifespan, event: removeEntityEvent)
        let collisionEffect = PostEventEffect(eventToPost: removeEntityEvent)
        let collisionEffectComponent = CollisionEffectComponent(entity: entity,
                                                                acceptableComponentsColliders: dissapearWhenCollideWith,
                                                                acceptableDirectionsToCollideFrom: [.up, .down, .left, .right],
                                                                collisionEffect: collisionEffect)
        return [physicsComponent, renderableComponent, attackableComponent,
                timerComponent, collisionEffectComponent]
    }
}
