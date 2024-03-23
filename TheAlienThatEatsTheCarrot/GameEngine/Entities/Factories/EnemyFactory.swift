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
        return []
    }
}

class NormalEnemyFactory: EnemyFactory {
    override func createComponents() -> [Component] {
        let enemyComponent = EnemyComponent(entity: entity)
        let renderableComponent = RenderableComponent(entity: entity, position: boardObject.position)
        let destroyableComponent = DestroyableComponent(entity: entity)
        return [enemyComponent, renderableComponent, destroyableComponent]
    }
}
