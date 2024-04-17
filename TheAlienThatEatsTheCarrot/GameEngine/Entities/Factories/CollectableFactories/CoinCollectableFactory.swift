//
//  CoinCollectableFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 30/3/24.
//

import Foundation

class CoinCollectableFactory: CollectableFactory {
    let type: ObjectType
    let value: Int

    init(boardObject: BoardObject, entity: Entity, type: ObjectType, value: Int) {
        self.type = type
        self.value = value
        super.init(boardObject: boardObject, entity: entity)
    }

    override func createComponents() -> [Component] {
        let size = CGSize(width: boardObject.width, height: boardObject.height)
        let collectableComponent = CollectableComponent(entity: entity)
        let renderableComponent = RenderableComponent(entity: entity,
                                                      position: boardObject.position,
                                                      objectType: type,
                                                      size: size)
        let physicsBody = PhysicsBody(shape: .rectangle, position: boardObject.position, size: size,
                                      categoryBitmask: Constants.collectableCategoryBitmask,
                                      collisionBitmask: Constants.collectibleCollisionBitmask,
                                      isDynamic: false, skipResolve: true)
        let physicsComponent = PhysicsComponent(entity: entity, physicsBody: physicsBody, disableGravity: true)
        let addCoinEffect = AddCoinEffect(value: value)
        let collisionEffectComponent = CollisionEffectComponent(entity: entity,
                                                                acceptableComponentsColliders: [PlayerComponent.self],
                                                                acceptableDirectionsToCollideFrom: [.up, .down, .left, .right],
                                                                collisionEffect: addCoinEffect)
        return [collectableComponent, renderableComponent, physicsComponent, collisionEffectComponent]
    }
}
