//
//  PushableBlockFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 5/4/24.
//

import Foundation

class PushableBlockFactory: BlockFactory {
    override func createComponents() -> [Component] {
        let size = CGSize(width: boardObject.width, height: boardObject.height)
        let blockComponent = BlockComponent(entity: entity)
        let renderableComponent = RenderableComponent(entity: entity,
                                                      position: boardObject.position,
                                                      objectType: .block(.pushable),
                                                      size: size)
        let physicsBody = PhysicsBody(shape: .rectangle, position: boardObject.position,
                                      size: size, categoryBitmask: Constants.blockCategoryBitmask,
                                      collisionBitmask: Constants.blockCollisionBitmask,
                                      isDynamic: true)
        let physicsComponent = PhysicsComponent(entity: entity, physicsBody: physicsBody)
        let movementPattern = MoveWhenPushedPattern(canBePushedFrom: [.left, .right],
                                                    canBePushedBy: [PlayerComponent.self])
        let movableComponent = MovableComponent(entity: entity, pattern: movementPattern)
        let frictionalComponent = FrictionalComponent(entity: entity)
        return [blockComponent, renderableComponent, physicsComponent, movableComponent, frictionalComponent]
    }
}
