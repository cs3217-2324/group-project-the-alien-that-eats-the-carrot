//
//  EnemyFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 22/3/24.
//

import Foundation

class EnemyFactory: EntityFactory {
    let boardObject: Enemy
    let entity: Entity

    init(from boardObject: Enemy, to entity: Entity) {
        self.boardObject = boardObject
        self.entity = entity
    }

    func createComponents() -> [Component] {
        []
    }
}

class NormalEnemyFactory: EnemyFactory {
    override func createComponents() -> [Component] {
        let enemyComponent = EnemyComponent(entity: entity)
        let renderableComponent = RenderableComponent(entity: entity, position: boardObject.position)
        let movableComponent = MovableComponent(entity: entity, velocity: CGVector(dx: 50.0, dy: 0), movementPattern: .leftRight)
        let destroyableComponent = DestroyableComponent(entity: entity)
        return [enemyComponent, renderableComponent, movableComponent, destroyableComponent]
    }
}
