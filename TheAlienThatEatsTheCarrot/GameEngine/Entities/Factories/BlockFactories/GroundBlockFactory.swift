//
//  GroundBlockFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

class GroundBlockFactory: BlockFactory {
    static let FRICTIONAL_STRENGTH = 100.0

    override func createComponents() -> [Component] {
        let size = CGSize(width: boardObject.width, height: boardObject.height)
        let blockComponent = BlockComponent(entity: entity)
        let renderableComponent = RenderableComponent(entity: entity,
                                                      position: boardObject.position,
                                                      objectType: .block(.ground),
                                                      size: size)
        let frictionalComponent = FrictionalComponent(entity: entity,
                                                      frictionalStrength: GroundBlockFactory.FRICTIONAL_STRENGTH)
        let physicsBody = PhysicsBody(shape: .rectangle, position: boardObject.position, size: size, categoryBitmask: Constants.blockCategoryBitmask, collisionBitmask: Constants.blockCollisionBitmask, isDynamic: false)
        let physicsComponent = PhysicsComponent(entity: entity, physicsBody: physicsBody)
        return [blockComponent, renderableComponent, frictionalComponent, physicsComponent]
    }
}
