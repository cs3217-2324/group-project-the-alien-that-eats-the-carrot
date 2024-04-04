//
//  NormalEnemyFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

class NormalEnemyFactory: EnemyFactory {
    static let SCORE = 100.0
    override func createComponents() -> [Component] {
        let size = CGSize(width: boardObject.width, height: boardObject.height)
        let enemyComponent = EnemyComponent(entity: entity)
        let renderableComponent = RenderableComponent(entity: entity,
                                                      position: boardObject.position,
                                                      objectType: .enemy(.normal),
                                                      size: size)
        let movableComponent = MovableComponent(entity: entity, pattern: LeftRightPattern())
        let attackableComponent = AttackableComponent(entity: entity, targetables: [PlayerComponent.self], attackStyle: MeleeAttackStyle())
        let physicsBody = PhysicsBody(shape: .rectangle,
                                      position: boardObject.position,
                                      size: size,
                                      categoryBitmask: Constants.enemyCategoryBitmask,
                                      collisionBitmask: Constants.enemyCollisionBitmask,
                                      isDynamic: true)
        physicsBody.velocity = CGVector(dx: 50.0, dy: 0)
        let physicsComponent = PhysicsComponent(entity: entity,
                                                physicsBody: physicsBody)
        let destroyableComponent = DestroyableComponent(entity: entity)
        let scoreComponent = ScoreComponent(entity: entity, score: NormalEnemyFactory.SCORE)
        return [enemyComponent, renderableComponent, movableComponent, attackableComponent,
                physicsComponent, destroyableComponent, scoreComponent]
    }
}
