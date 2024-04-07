//
//  NormalCharacterFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 2/4/24.
//

import Foundation

class NormalCharacterFactory: CharacterFactory {
    override func createComponents() -> [Component] {
        let size = CGSize(width: 80.0, height: 100.0)
        let physicsBody = PhysicsBody(shape: .rectangle,
                                      position: position,
                                      size: size,
                                      categoryBitmask: Constants.characterCategoryBitmask,
                                      collisionBitmask: Constants.characterCollisionBitmask,
                                      isDynamic: true)
        let renderableComponent = RenderableComponent(entity: entity, position: position, objectType: .character(.normal))
        let playerComponent = PlayerComponent(entity: entity)
        let canUsePowerupComponent = CanUsePowerupComponent(entity: entity)
        let physicsComponent = PhysicsComponent(entity: entity, physicsBody: physicsBody)
        let jumpStateComponent = JumpStateComponent(entity: entity)
        let inventoryComponent = InventoryComponent(entity: entity)
        let cameraComponent = CameraComponent(entity: entity)
        let attackStyles: [any AttackStyle] = [JumpAttackStyle(targetables: [EnemyComponent.self]),
                                               HeadAttackStyle(targetables: [BlockComponent.self])]
        let attackableComponent = AttackableComponent(entity: entity,
                                                      attackStyles: attackStyles)
        let destroyableComponent = DestroyableComponent(entity: entity, lives: 3, maxLives: 3)
        let respawnableComponent = RespawnableComponent(entity: entity, spawnPoint: position)
        return [renderableComponent, playerComponent, canUsePowerupComponent, physicsComponent,
                jumpStateComponent, inventoryComponent, cameraComponent, attackableComponent,
                destroyableComponent, respawnableComponent]
    }
}
