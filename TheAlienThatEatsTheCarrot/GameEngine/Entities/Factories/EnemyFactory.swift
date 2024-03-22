//
//  EnemyFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 22/3/24.
//

import Foundation

class EnemyFactory: EntityFactory {
    func createComponents() -> [Component] {
        return []
    }
}

class NormalEnemyFactory: EnemyFactory {
    let boardObject: NormalEnemy
    let entity: Entity

    init(from boardObject: NormalEnemy, to entity: Entity) {
        self.boardObject = boardObject
        self.entity = entity
    }

    override func createComponents() -> [Component] {
        let enemyComponent = EnemyComponent(entity: entity)
        let positionalComponent = PositionalComponent(entity: entity, position: boardObject.position)
        let destroyableComponent = DestroyableComponent(entity: entity)
        return [enemyComponent, positionalComponent, destroyableComponent]
    }
}
