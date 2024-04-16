//
//  NormalCharacterFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 2/4/24.
//

import Foundation

class NormalCharacterFactory: CharacterFactory {
    static let DEFAULT_LIVES = 3
    override func createComponents() -> [Component] {
        let position = boardObject.position
        let size = CGSize(width: boardObject.width, height: boardObject.height)
        let physicsBody = PhysicsBody(shape: .rectangle,
                                      position: position,
                                      size: size,
                                      categoryBitmask: Constants.characterCategoryBitmask,
                                      collisionBitmask: Constants.characterCollisionBitmask,
                                      isDynamic: true, restitution: 0)
        let renderableComponent = RenderableComponent(entity: entity, position: position, objectType: .character(.normal), size: size)
        let playerComponent = PlayerComponent(entity: entity)
        let physicsComponent = PhysicsComponent(entity: entity, physicsBody: physicsBody)
        let jumpStateComponent = JumpStateComponent(entity: entity)
        let inventoryComponent = InventoryComponent(entity: entity)
        let cameraComponent = CameraComponent(entity: entity)
        let attackStyles: [any AttackStyle] = [JumpAttackStyle(targetables: [EnemyComponent.self]),
                                               HeadAttackStyle(targetables: [BlockComponent.self])]
        let attackableComponent = AttackableComponent(entity: entity,
                                                      attackStyles: attackStyles)
        let playerDiedEvent = PlayerDiedEvent()
        let destroyableComponent = DestroyableComponent(entity: entity,
                                                        lives: NormalCharacterFactory.DEFAULT_LIVES,
                                                        maxLives: NormalCharacterFactory.DEFAULT_LIVES,
                                                        onLiveDecrease: playerDiedEvent)
        let respawnableComponent = RespawnableComponent(entity: entity, spawnPoint: position)
        return [renderableComponent, playerComponent, physicsComponent,
                jumpStateComponent, inventoryComponent, cameraComponent, attackableComponent,
                destroyableComponent, respawnableComponent]
    }
}
