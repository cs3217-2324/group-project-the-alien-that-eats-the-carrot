//
//  MushroomBlockFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 11/4/24.
//

import Foundation

class MushroomBlockFactory: BlockFactory {
    static let KNOCKBACK_STRENGTH = 10_000.0
    override func createComponents() -> [Component] {
        let size = CGSize(width: boardObject.width, height: boardObject.height)
        let blockComponent = BlockComponent(entity: entity)
        let renderableComponent = RenderableComponent(entity: entity,
                                                      position: boardObject.position,
                                                      objectType: .block(.mushroom),
                                                      size: size)
        let physicsBody = PhysicsBody(shape: .rectangle, position: boardObject.position,
                                      size: size, categoryBitmask: Constants.blockCategoryBitmask,
                                      collisionBitmask: Constants.blockCollisionBitmask,
                                      isDynamic: false)
        let physicsComponent = PhysicsComponent(entity: entity, physicsBody: physicsBody)
        let frictionalComponent = FrictionalComponent(entity: entity)
        let destroyableComponent = DestroyableComponent(entity: entity, maxHealth: 10.0, maxLives: 1, isInvinsible: false)
        let meleeAttackStyle = MeleeAttackStyle(targetables: [PlayerComponent.self],
                                                damage: .zero,
                                                acceptableAttackDirections: [.down],
                                                knockbackStrength: MushroomBlockFactory.KNOCKBACK_STRENGTH,
                                                cooldownDuration: .zero)
        let attackableComponent = AttackableComponent(entity: entity, attackStyles: [meleeAttackStyle])
        return [blockComponent, renderableComponent, physicsComponent, frictionalComponent,
                destroyableComponent, attackableComponent]
    }
}
