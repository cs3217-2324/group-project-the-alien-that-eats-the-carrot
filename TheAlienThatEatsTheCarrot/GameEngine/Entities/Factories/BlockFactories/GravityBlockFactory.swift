//
//  GravityBlockFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 11/4/24.
//

import Foundation

class GravityBlockFactory: BlockFactory {
    static let GRAVITY_STRENGTH = 700.0
    static let GRAVITY_RADIUS = 50.0
    override func createComponents() -> [Component] {
        let size = CGSize(width: boardObject.width, height: boardObject.height)
        let blockComponent = BlockComponent(entity: entity)
        let renderableComponent = RenderableComponent(entity: entity,
                                                      position: boardObject.position,
                                                      objectType: .block(.gravity),
                                                      size: size)
        let physicsBody = PhysicsBody(shape: .rectangle, position: boardObject.position,
                                      size: size, categoryBitmask: Constants.blockCategoryBitmask,
                                      collisionBitmask: Constants.blockCollisionBitmask,
                                      isDynamic: false)
        let physicsComponent = PhysicsComponent(entity: entity, physicsBody: physicsBody)
        let frictionalComponent = FrictionalComponent(entity: entity)
        let destroyableComponent = DestroyableComponent(entity: entity, maxHealth: 10.0, maxLives: 1, isInvinsible: false)
        let gravityAttackStyle = ApplyGravityToNearbyObjectsAttackStyle(targetables: [PlayerComponent.self],
                                                                        damage: .zero,
                                                                        forceStrength: GravityBlockFactory.GRAVITY_STRENGTH,
                                                                        radius: GravityBlockFactory.GRAVITY_RADIUS)
        let attackableComponent = AttackableComponent(entity: entity, attackStyles: [gravityAttackStyle])
        let removeGravityAttackComponentEffect = RemoveComponentEffect(componentsToRemove: [AttackableComponent.self],
                                                                       removeFrom: entity)
        let collisionEffectComponent = CollisionEffectComponent(entity: entity,
                                                                acceptableComponentsColliders: [PlayerComponent.self],
                                                                acceptableDirectionsToCollideFrom: [.up, .down, .left, .right],
                                                                collisionEffect: removeGravityAttackComponentEffect)
        return [blockComponent, renderableComponent, physicsComponent,
                frictionalComponent, destroyableComponent, attackableComponent,
                collisionEffectComponent]
    }
}
