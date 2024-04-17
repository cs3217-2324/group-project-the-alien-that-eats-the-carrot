//
//  HeartCollectableFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 30/3/24.
//

import Foundation

class HeartCollectableFactory: CollectableFactory {
    override func createComponents() -> [Component] {
        let size = CGSize(width: boardObject.width, height: boardObject.height)
        let collectableComponent = CollectableComponent(entity: entity)
        let renderableComponent = RenderableComponent(entity: entity,
                                                      position: boardObject.position,
                                                      objectType: .collectable(.heart),
                                                      size: size)
        let physicsBody = PhysicsBody(shape: .rectangle, position: boardObject.position, size: size,
                                      categoryBitmask: Constants.collectableCategoryBitmask,
                                      collisionBitmask: Constants.collectibleCollisionBitmask,
                                      isDynamic: false, skipResolve: true)
        let physicsComponent = PhysicsComponent(entity: entity, physicsBody: physicsBody, disableGravity: true)
        let addLifeEffect = AddLifeEffect()
        let collisionEffectComponent = CollisionEffectComponent(entity: entity,
                                                                acceptableComponentsColliders: [PlayerComponent.self],
                                                                acceptableDirectionsToCollideFrom: [.up, .down, .left, .right],
                                                                collisionEffect: addLifeEffect)
        return [collectableComponent, renderableComponent, physicsComponent, collisionEffectComponent]
    }
}
