//
//  SpikeBlockFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 5/4/24.
//

import Foundation

class SpikeBlockFactory: BlockFactory {
    static let DAMAGE = 20.0
    static let COOLDOWN = 0.5
    static let KNOCKBACK_STRENGTH = 1_000.0
    static let BLOCK_TO_HEIGHT_RATIO = 8.0

    override func createComponents() -> [Component] {
        let size = CGSize(width: boardObject.width,
                          height: boardObject.height / SpikeBlockFactory.BLOCK_TO_HEIGHT_RATIO)
        let blockComponent = BlockComponent(entity: entity)
        let renderableComponent = RenderableComponent(entity: entity,
                                                      position: boardObject.position,
                                                      objectType: .block(.spike),
                                                      size: size)
        let physicsBody = PhysicsBody(shape: .rectangle, position: boardObject.position,
                                      size: size, categoryBitmask: Constants.blockCategoryBitmask,
                                      collisionBitmask: Constants.blockCollisionBitmask,
                                      isDynamic: false)
        let physicsComponent = PhysicsComponent(entity: entity, physicsBody: physicsBody)
        let attackStyle = MeleeAttackStyle(acceptableAttackDirections: [.up, .left, .down],
                                           knockbackStrength: SpikeBlockFactory.KNOCKBACK_STRENGTH,
                                           cooldownDuration: SpikeBlockFactory.COOLDOWN)
        let attackableComponent = AttackableComponent(entity: entity,
                                                      targetables: [PlayerComponent.self],
                                                      damage: SpikeBlockFactory.DAMAGE,
                                                      attackStyle: attackStyle)
        return [blockComponent, renderableComponent, physicsComponent, attackableComponent]
    }
}
