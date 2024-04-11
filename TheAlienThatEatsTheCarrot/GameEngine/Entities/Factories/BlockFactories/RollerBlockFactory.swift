//
//  RollerBlockFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 11/4/24.
//

import Foundation

class RollerBlockFactory: BlockFactory {
    override func createComponents() -> [Component] {
        let size = CGSize(width: boardObject.width, height: boardObject.height)
        let blockComponent = BlockComponent(entity: entity)
        let renderableComponent = RenderableComponent(entity: entity,
                                                      position: boardObject.position,
                                                      objectType: .block(.roller),
                                                      size: size)
        let physicsBody = PhysicsBody(shape: .rectangle, position: boardObject.position,
                                      size: size, categoryBitmask: Constants.blockCategoryBitmask,
                                      collisionBitmask: Constants.blockCollisionBitmask,
                                      isDynamic: false, restitution: 0)
        let physicsComponent = PhysicsComponent(entity: entity, physicsBody: physicsBody)
        let frictionalComponent = FrictionalComponent(entity: entity, frictionalStrength: 0)
        let destroyableComponent = DestroyableComponent(entity: entity, maxHealth: 10.0, maxLives: 1, isInvinsible: false)
        let movableComponent = MovableComponent(entity: entity, pattern: LeftRightPattern())
        let movePhysicsBodyOnTopEffect = MoveDynamicPhysicsObjectOnTopEffect()
        let collisionEffectComponent = CollisionEffectComponent(entity: entity,
                                                                acceptableComponentsColliders: [PlayerComponent.self, EnemyComponent.self],
                                                                acceptableDirectionsToCollideFrom: [.up], collisionEffect: movePhysicsBodyOnTopEffect)
        return [blockComponent, renderableComponent, physicsComponent, frictionalComponent,
                destroyableComponent, movableComponent, collisionEffectComponent]
    }
}
