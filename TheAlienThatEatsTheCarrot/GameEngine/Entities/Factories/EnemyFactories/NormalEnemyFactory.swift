//
//  NormalEnemyFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

class NormalEnemyFactory: EnemyFactory {
    override func createComponents() -> [Component] {
        let enemyComponent = EnemyComponent(entity: entity)
        let renderableComponent = RenderableComponent(entity: entity, position: boardObject.position, objectType: .enemy(.normal))
        let movableComponent = MovableComponent(entity: entity, pattern: LeftRightPattern())
        let attackableComponent = AttackableComponent(entity: entity, attackStyle: MeleeAttackStyle())
        let physicsBody = PhysicsBody(shape: .rectangle,
                                      position: CGPoint(x: 200.0, y: 200.0),
                                      size: CGSize(width: 50.0, height: 50.0),
                                      isDynamic: false)
        physicsBody.velocity = CGVector(dx: 50.0, dy: 0)
        let physicsComponent = PhysicsComponent(entity: entity,
                                                physicsBody: physicsBody)
        let destroyableComponent = DestroyableComponent(entity: entity)
        return [enemyComponent, renderableComponent, movableComponent, attackableComponent,
                physicsComponent, destroyableComponent]
    }
}
