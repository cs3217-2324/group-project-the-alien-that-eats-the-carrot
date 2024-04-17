//
//  NormalEnemyFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

class NormalEnemyFactory: EnemyFactory {
    static let SCORE: Int = 100

    override func createComponents() -> [Component] {
        let size = CGSize(width: boardObject.width, height: boardObject.height)
        let enemyComponent = EnemyComponent(entity: entity)
        let renderableComponent = RenderableComponent(entity: entity,
                                                      position: boardObject.position,
                                                      objectType: .enemy(.normal),
                                                      size: size)
        let movableComponent = MovableComponent(entity: entity, pattern: LeftRightPattern())
        let attackStyles = [MeleeAttackStyle(targetables: [PlayerComponent.self])]
        let attackableComponent = AttackableComponent(entity: entity,
                                                      attackStyles: attackStyles)
        let physicsBody = PhysicsBody(shape: .rectangle,
                                      position: boardObject.position,
                                      size: size,
                                      categoryBitmask: Constants.enemyCategoryBitmask,
                                      collisionBitmask: Constants.enemyCollisionBitmask,
                                      isDynamic: true, mass: EnemyFactory.MASS)
        let physicsComponent = PhysicsComponent(entity: entity,
                                                physicsBody: physicsBody)
        let destroyableComponent = DestroyableComponent(entity: entity, onDestroyed: EnemyKilledEvent(entity: entity))
        let scoreComponent = ScoreComponent(entity: entity, score: NormalEnemyFactory.SCORE)
        return [enemyComponent, renderableComponent, movableComponent, attackableComponent,
                physicsComponent, destroyableComponent, scoreComponent]
    }
}
